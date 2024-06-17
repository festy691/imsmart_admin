import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/bottom_sheets.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/city_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/models/transaction_model.dart';
import 'package:imsmart_admin/pages/home_screens/apartment_screens/components/apartment_cards.dart';
import 'package:imsmart_admin/pages/home_screens/apartment_screens/update_apartment_screen.dart';
import 'package:imsmart_admin/pages/home_screens/apartment_screens/view_more_apartment_screen.dart';
import 'package:imsmart_admin/pages/home_screens/book_room_screen.dart';
import 'package:imsmart_admin/pages/home_screens/city_views/city_detail_screen.dart';
import 'package:imsmart_admin/pages/home_screens/components/place_card.dart';
import 'package:imsmart_admin/pages/home_screens/components/top_rated_card.dart';
import 'package:imsmart_admin/pages/home_screens/transaction_screens/transaction_detail_screen.dart';
import 'package:imsmart_admin/pages/home_screens/transaction_screens/transactions_screen.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RoomPropertyModel> roomProperties = [];
  List<CityModel> cities = [];
  bool isLoading = false;
  int _selected = 0;

  late PropertyProvider _provider;
  _loadProperties () async {
    isLoading = true;
    if(mounted){
      setState(() {});
    }
    await Future.wait([
      _provider.loadTopApartments(context: context),
      _provider.loadAllApartments(context: context),
      _provider.loadAllCities(context: context, load: false),
      _provider.loadTransactions(context: context, load: false),
    ]);
    isLoading = false;
    if(mounted){
      setState(() {});
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    _provider = context.provideOnce<PropertyProvider>();
    super.initState();

    _loadProperties();
  }

  @override
  Widget build(BuildContext context) {
    roomProperties = _provider.topRated;
    roomProperties.sort((a,b)=> b.totalRating.compareTo(a.totalRating));
    cities = _provider.cities;
    return Scaffold(
      backgroundColor: Pallet.bgColor,
      body: UpgradeAlert(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 250.h,
              child: ImageLoader(
                path: AppAssets.homeImg,
                width: 1.sw,
                height: 250.h,
                fit: BoxFit.fitWidth,
              ),
            ),

            Positioned(
              top: 60.h,
              left: 32.w,
              right: 32.w,
              child: ImageLoader(
                path: AppAssets.imSmartLogo,
                width: 160.w,
                fit: BoxFit.fitWidth,
              ),
            ),

            if(isLoading) Positioned(
              top: 270.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: ImageLoader(
                  path: AppAssets.loaderLottie,
                  width: 120.w,
                  height: 120.h,
                ),
              ),
            ),

            if(!isLoading) Positioned(
              top: 270.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: _selected == 0 ? _home() : _selected == 1 ? _booking() : _manage(),
            ),

            Positioned(
              top: 220.h,
              left: 32.w,
              right: 32.w,
              height: 60.h,
              child: Container(
                height: 60.h,
                width: 1.w,
                padding: EdgeInsets.symmetric(horizontal: 8.w),
                decoration: BoxDecoration(
                  color: Pallet.white,
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _menuCard(title: "Home", isActive: _selected == 0, index: 0, onTap: (){
                      _selected = 0;
                      if(mounted){
                        setState(() {});
                      }
                    }),

                    Container(width: 1.w, height: 40.h, color: Pallet.grey.withOpacity(0.5),),

                    _menuCard(title: "Bookings", isActive: _selected == 1, index: 1, onTap: (){
                      _selected = 1;
                      if(mounted){
                        setState(() {});
                      }
                    }),

                    Container(width: 1.w, height: 40.h, color: Pallet.grey.withOpacity(0.5),),

                    _menuCard(title: "Manage", isActive: _selected == 2, index: 2, onTap: (){
                      _selected = 2;
                      if(mounted){
                        setState(() {});
                      }
                    }),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _home(){
    return ListView(
      children: [
        SizedBox(height: setHeight(32)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Top rated",
                textStyle: body4TextStyle.copyWith(color: Pallet.black.withOpacity(0.7), fontSize: 20.sp),
              ),

              TextView(
                text: "View all",
                textStyle: body4TextStyle.copyWith(color: Pallet.blue.withOpacity(0.7), fontSize: 14.sp),
                onTap: (){
                  PageRouter.gotoWidget(ViewMoreApartments(), context);
                },
              ),
            ],
          ),
        ),

        SizedBox(height: setHeight(16)),

        Container(
          width: 1.sw,
          height: 220.h,
          child: ListView.builder(
            itemCount: roomProperties.length > 4 ? 4 : roomProperties.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index){
              RoomPropertyModel model = roomProperties[index];
              return Padding(
                padding: EdgeInsets.only(right: 20.w, left: index == 0 ? 20.w : 0),
                child: TopRatedCard(
                  propertyModel: model,
                  onTap: (){
                    PageRouter.gotoWidget(BookRoomScreen(propertyId: roomProperties[index].id), context);
                  },
                ),
              );
            },
          ),
        ),

        SizedBox(height: setHeight(32)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Explore places",
                textStyle: body4TextStyle.copyWith(color: Pallet.black.withOpacity(0.7), fontSize: 20.sp),
              ),

              TextView(
                text: "",
                textStyle: body4TextStyle.copyWith(color: Pallet.blue.withOpacity(0.7), fontSize: 14.sp),
              ),
            ],
          ),
        ),

        SizedBox(height: setHeight(16)),

        Container(
          width: 1.sw,
          height: 150.h,
          child: ListView.builder(
            itemCount: cities.length > 3 ? 3 : cities.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index){
              CityModel model = cities[index];
              return Padding(
                padding: EdgeInsets.only(right: 20.w, left: index == 0 ? 20.w : 0),
                child: PlaceCard(
                  city: model,
                  onTap: (){
                    PageRouter.gotoWidget(CityDetailScreen(cityId: cities[index].id), context);
                  },
                ),
              );
            },
          ),
        ),

        SizedBox(height: setHeight(120)),

      ],
    );
  }

  Widget _booking(){
    return Column(
      children: [
        SizedBox(height: setHeight(32)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextView(
                text: "Recent bookings",
                textStyle: body4TextStyle.copyWith(color: Pallet.black.withOpacity(0.7), fontSize: 20.sp),
              ),

              TextView(
                text: "View all",
                textStyle: body4TextStyle.copyWith(color: Pallet.blue.withOpacity(0.7), fontSize: 14.sp),
                onTap: (){
                  PageRouter.gotoWidget(TransactionScreen(), context);
                },
              ),
            ],
          ),
        ),

        Consumer<PropertyProvider>(builder: (__, provider, _) {
            return Expanded(
              child: ListView.separated(
                itemCount: provider.transactions.length > 10 ? 10 : provider.transactions.length,
                itemBuilder: (BuildContext context, int index){
                  TransactionModel model = provider.transactions[index];
                  String name = (model.firstName.toString().split("").first) + (model.lastName.toString().split("").isNotEmpty ? model.lastName.toString().split("").first : model.firstName.substring(1, 1));
                  return ListTile(
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
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(color: Pallet.lightGrey, thickness: 1,);
                },
              ),
            );
          }
        ),
      ],
    );
  }

  Widget _manage(){
    return Column(
      children: [

        SizedBox(height: setHeight(32)),

        Expanded(
          child: GridView.extent(
            maxCrossAxisExtent: 200.0.w, // maximum item width
            mainAxisSpacing: 16.0.h, // spacing between rows
            crossAxisSpacing: 16.0.w, // spacing between columns
            padding: EdgeInsets.all(8.0.w), // padding around the grid
            children: _provider.apartments.map((item) {
              return ApartmentCard(propertyModel: item, onTap: (){
                PageRouter.gotoWidget(UpdateApartmentScreen(property: item,), context);
              });
            }).toList(),
          ),
        ),

        SizedBox(height: setHeight(32)),

      ],
    );
  }

  Widget _menuCard({required String title, bool isActive = false, int index = 0, required Function onTap}){
    return InkWell(
      onTap: ()=> onTap(),
      child: Container(
        height: 50.h,
        width: 0.25.sw,
        decoration: BoxDecoration(
          color: isActive ? Pallet.black : Pallet.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(index == 0 ? 16.r : 0),
            bottomLeft: Radius.circular(index == 0 ? 16.r : 0),
            topRight: Radius.circular(index == 2 ? 16.r : 2),
            bottomRight: Radius.circular(index == 2 ? 16.r : 2),
          ),
        ),
        child: Center(
          child: TextView(
            text: title,
            textStyle: body4TextStyle.copyWith(color: isActive ? Pallet.white : Pallet.black.withOpacity(0.7), fontSize: 14.sp),
          ),
        ),
      ),
    );
  }

  String url() {
    final phone = whatsAppPhoneNumber;
    if (Platform.isAndroid) {
      // add the [https]
      return "https://wa.me/$phone/?text=${Uri.parse('Hello, good day')}"; // new line
    } else {
      // add the [https]
      return "https://api.whatsapp.com/send?phone=$phone&text=${Uri.parse('Hello, good day')}"; // new line
    }
  }

  void openTransactionDetail(BuildContext context, {required TransactionModel transactionModel}) {
    BottomSheets.showSheet<String>(
      context,
      child: TransactionDetailScreen(transactionModel: transactionModel,),
    );
  }
}
