import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/bottom_sheets.dart';
import 'package:imsmart_admin/core/widget/empty_screen.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/api_response.dart';
import 'package:imsmart_admin/models/transaction_model.dart';
import 'package:imsmart_admin/pages/home_screens/transaction_screens/transaction_detail_screen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:timeago/timeago.dart' as timeago;

class TransactionScreen extends StatefulWidget {
  const TransactionScreen({super.key});

  @override
  State<TransactionScreen> createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  late PropertyProvider _provider;
  int cPage = 1;
  int limitPerPage = 10;

  late APIResponse response;

  bool isLoading = false;
  _loadData ({required int page, required int limit}) async {
    //isLoading = true;
    /*if(mounted){
      setState(() {});
    }*/
    response = await _provider.loadTransactions(context: context, page: page, limit: limit, load: false);
    /*isLoading = false;
    if(mounted){
      setState(() {});
    }*/
  }

  late RefreshController _refreshController;

  void _onRefresh() async{
    cPage = 1;
    await _loadData(page: cPage, limit: limitPerPage);
    _refreshController.loadComplete();

    _refreshController.refreshToIdle();
  }

  void _onLoading() async {
    cPage = response.data["page"];
    if(cPage == response.data["pages"]){
      return _refreshController.loadComplete();
    }
    cPage = cPage + 1;
    await _loadData(page: cPage, limit: limitPerPage);
    _refreshController.loadComplete();
  }

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _checkToday(DateTime date) {
    DateTime now = DateTime.now();
    final difference = daysBetween(date.add(Duration(hours: 1)), now);
    if (difference == 0) {
      return "Today";
    } else if (difference == 1) {
      return "Yesterday";
    }
    return timeago.format(date);
  }

  @override
  void initState() {
    // TODO: implement initState
    _provider = context.provideOnce<PropertyProvider>();
    _refreshController = RefreshController(initialRefresh: true,);
    super.initState();

    _loadData(page: 1, limit: limitPerPage);
  }

  @override
  Widget build(BuildContext context) {
    var format = DateFormat.Hm('en_US');
    PropertyProvider propertyProvider = Provider.of<PropertyProvider>(context);
    return BackgroundWidget(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        child: Stack(
          children: [
            if(isLoading) Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Center(
                child: ImageLoader(
                  path: AppAssets.loaderLottie,
                  width: 120.w,
                  height: 120.h,
                ),
              ),
            ),

            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Column(
                children: [
                  Expanded(
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: const WaterDropHeader(),
                      footer: CustomFooter(
                        builder: (context, mode){
                          Widget body ;
                          if(mode==LoadStatus.idle){
                            body =  TextView(text: "pull up load");
                          } else if(mode==LoadStatus.loading){
                            body =  CupertinoActivityIndicator();
                          }
                          else if(mode == LoadStatus.failed){
                            body =  TextView(text: "Load Failed!Click retry!");
                          }
                          else if(mode == LoadStatus.canLoading){
                            body =  TextView(text: "release to load more");
                          } else{
                            body =  TextView(text: "No more Data");
                          }
                          return Container(
                            height: 55.0,
                            child: Center(child:body),
                          );
                        },
                      ),
                      controller: _refreshController,
                      onRefresh: _onRefresh,
                      onLoading: _onLoading,
                      child: _provider.transactions.length > 0 ? StickyGroupedListView<TransactionModel, DateTime>(
              //physics: ClampingScrollPhysics(),
              elements: _provider.transactions,
              order: StickyGroupedListOrder.DESC,
              groupBy: (TransactionModel element) {
                DateTime date = DateTime.parse(element.date);
                return DateTime(date.year, date.month, date.day);
              },
              groupComparator: (DateTime value1, DateTime value2) {
                return value1.compareTo(value2);
              },
              itemComparator: (TransactionModel element1, TransactionModel element2) {
                DateTime date1 = DateTime.parse(element1.date);
                DateTime date2 = DateTime.parse(element2.date);
                return date1.compareTo(date2);
              },
              floatingHeader: true,
              shrinkWrap: true,
              groupSeparatorBuilder: (TransactionModel element) => Container(
                height: 50.h,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.h, left: 20.w),
                    child: Text(
                      '${_checkToday(DateTime.parse(element.date))}',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(14),
                          color: Pallet.black.withOpacity(0.7)),
                    ),
                  ),
                ),
              ),
              itemBuilder: (_, TransactionModel element) {
                TransactionModel model = element;
                String name = (model.firstName.toString().split("").first) + (model.lastName.toString().split("").isNotEmpty ? model.lastName.toString().split("").first : model.firstName.substring(1, 1));

                return Column(
                  children: [
                    ListTile(
                      isThreeLine: true,
                      dense: true,
                      leading: Container(
                        height: 50.w,
                        width: 50.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                          child: TextView(
                            text: name,
                            textStyle: TextStyle(
                                fontSize: 16.sp,
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.w500,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      title: TextView(
                        text: "${model.property['title']} - ${model.firstName}",
                        textOverflow: TextOverflow.ellipsis,
                        textStyle: TextStyle(
                          fontSize: ScreenUtil().setSp(16),
                          fontFamily: fontFamily,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextView(
                            text: "${formatMoney(model.transactionAmount)}",
                            textOverflow: TextOverflow.ellipsis,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(14),
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),

                          TextView(
                            text: "${formatDate(model.checkinDate, format: 'MMM dd, yyyy')} - ${formatDate(model.checkoutDate, format: 'MMM dd, yyyy')}",
                            textOverflow: TextOverflow.ellipsis,
                            textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(
                        model.status == "pending" ? Icons.pending :
                        model.status == "processing" ? Icons.downloading :
                        model.status == "completed" ? Icons.check_circle : Icons.cancel,
                        size: 20.w,
                        color:  model.status == "pending" ? Pallet.mainOrange :
                        model.status == "processing" ? Pallet.blue :
                        model.status == "completed" ? Pallet.green : Pallet.red,
                      ),
                      onTap: (){
                        openTransactionDetail(context, transactionModel: model);
                      },
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                );
              },
              )
                          :
                      EmptyScreen(
                        title: 'You don\'t have any notification',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openTransactionDetail(BuildContext context, {required TransactionModel transactionModel}) {
    BottomSheets.showSheet<String>(
      context,
      child: TransactionDetailScreen(transactionModel: transactionModel,),
    );
  }
}
