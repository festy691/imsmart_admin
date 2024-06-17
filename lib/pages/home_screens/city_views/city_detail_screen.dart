import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/empty_screen.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/api_response.dart';
import 'package:imsmart_admin/models/city_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/apartment_screens/view_more_apartment_screen.dart';
import 'package:imsmart_admin/pages/home_screens/book_room_screen.dart';
import 'package:imsmart_admin/pages/home_screens/components/top_rated_card.dart';

class CityDetailScreen extends StatefulWidget {
  final String cityId;
  const CityDetailScreen({super.key, required this.cityId});

  @override
  State<CityDetailScreen> createState() => _CityDetailScreenState();
}

class _CityDetailScreenState extends State<CityDetailScreen> {
  late PropertyProvider provider;
  CityModel? city;
  List<RoomPropertyModel> apartments = [];

  bool isExpandable = false;

  bool isLoadingProperty = false;
  _loadProperty () async {
    isLoadingProperty = true;
    if(mounted){
      setState(() {});
    }
    APIResponse result = await provider.loadSingleCity(context: context, cityId: widget.cityId);
    if(!result.error){
      city = provider.city;
      APIResponse response = await provider.loadAllApartments(context: context, cityId: widget.cityId);
      if (!response.error){
        apartments = provider.apartments;
      }
    }
    isLoadingProperty = false;
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    provider = context.provideOnce<PropertyProvider>();
    _loadProperty();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if(isLoadingProperty) Positioned(
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

          if(!isLoadingProperty && city == null) Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(child: EmptyScreen(title: "City not found",)),
          ),

          if(!isLoadingProperty && city != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 385.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    height: 385.h,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30.w), bottomRight: Radius.circular(30.w),)
                      ),
                      child: ImageLoader(
                        path: city?.displayImage,
                        width: 1.sw,
                        height: 385.h,
                        curve: 30.w,
                        isCurvedEdge: true,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  Positioned(
                    bottom: 24.h,
                    right: 20.w,
                    left: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextView(
                          text: "${city?.title}",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(22),
                            fontWeight: FontWeight.w700,
                            color: Pallet.white,
                          )
                        ),

                        SizedBox(height: 8.h),

                        TextView(
                          text: "A modern city with easy access road, lovely views, and a lively city",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(14),
                            fontWeight: FontWeight.w400,
                            color: Pallet.white,
                          )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          if(!isLoadingProperty && city != null) Positioned(
            top: 385.h,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 32.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextView(
                        text: "About",
                        textStyle: buttonTextStyle.copyWith(
                          fontSize: setSp(20),
                          fontWeight: FontWeight.w700,
                          color: Pallet.black,
                        )
                    ),
                  ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: TextView(
                      text: city?.description,
                      maxLines: isExpandable ? 30 : 3,
                      textOverflow: TextOverflow.ellipsis,
                      textStyle: buttonTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Pallet.semiDarkGrayAccent,
                      ),
                    ),
                  ),

                  SizedBox(height: 4.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: TextView(
                      onTap: () {
                        setState(() {
                          isExpandable = !isExpandable;
                        });
                      },
                      text: isExpandable ? "Read Less" : "Read More. . .",
                      textStyle: buttonTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Pallet.primaryColor,
                        // height: 0.25,
                      ),
                    ),
                  ),

                  SizedBox(height: 24.h),

                  if(apartments.isNotEmpty)Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Apartments",
                          textStyle: body4TextStyle.copyWith(color: Pallet.black.withOpacity(0.7), fontSize: 20.sp),
                        ),

                        TextView(
                          text: "View all",
                          textStyle: body4TextStyle.copyWith(color: Pallet.blue.withOpacity(0.7), fontSize: 14.sp),
                          onTap: (){
                            PageRouter.gotoWidget(ViewMoreApartments(cityId: city?.id,), context);
                          },
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: setHeight(12)),

                  Container(
                    width: 1.sw,
                    height: 220.h,
                    child: ListView.builder(
                      itemCount: apartments.length > 3 ? 3 : apartments.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index){
                        RoomPropertyModel model = apartments[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 20.w, left: index == 0 ? 20.w : 0),
                          child: TopRatedCard(
                            propertyModel: model,
                            onTap: (){
                              PageRouter.gotoWidget(BookRoomScreen(propertyId: apartments[index].id), context);
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  SizedBox(height: setHeight(32)),

                ],
              ),
            ),
          ),

          Positioned(
            top: 56.h,
            left: 12.w,
            child: Container(
              height: 36.w,
              width: 36.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Pallet.primaryColor
              ),
              child: ImageLoader(
                path: AppAssets.arrowBack,
                dColor: Pallet.white,
                width: 32.w,
                height: 16.h,
                fit: BoxFit.fitWidth,
                onTap: () {
                  PageRouter.goBack(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
