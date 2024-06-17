import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/apartment_screens/components/apartment_cards.dart';
import 'package:imsmart_admin/pages/home_screens/book_room_screen.dart';

class ViewMoreApartments extends StatefulWidget {
  String? cityId;
  ViewMoreApartments({super.key, this.cityId});

  @override
  State<ViewMoreApartments> createState() => _ViewMoreApartmentsState();
}

class _ViewMoreApartmentsState extends State<ViewMoreApartments> {
  late PropertyProvider provider;

  List<RoomPropertyModel> _apartments = [];

  int page = 1;
  int limit = 10;

  bool isLoading = false;

  _loadData() async {
    isLoading = true;
    if(mounted){
      setState(() {});
    }
    if(widget.cityId != null) {
      await provider.loadAllApartments(context: context, cityId: widget.cityId!);
      _apartments = provider.apartments;
    } else {
      await provider.loadTopApartments(context: context);
      _apartments = provider.topRated;
    }
    isLoading = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    provider = context.provideOnce<PropertyProvider>();
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.primaryColor,
        leading: ImageLoader(
          path: AppAssets.arrowBack,
          dColor: Pallet.white,
          width: 24.w,
          fit: BoxFit.fitWidth,
          onTap: () {
            PageRouter.goBack(context);
          },
        ),
        title: TextView(
          text: "Apartments",
          textStyle: body1TextStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Pallet.white,
          ),
        ),
      ),
      body: Container(
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
              top: 32.h,
              bottom: 0,
              left: 0,
              right: 0,
              child: GridView.extent(
                maxCrossAxisExtent: 200.0.w, // maximum item width
                mainAxisSpacing: 16.0.h, // spacing between rows
                crossAxisSpacing: 16.0.w, // spacing between columns
                padding: EdgeInsets.all(8.0), // padding around the grid
                children: _apartments.map((item) {
                  return ApartmentCard(propertyModel: item, onTap: (){
                    PageRouter.gotoWidget(BookRoomScreen(propertyId: item.id,), context);
                  });
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
