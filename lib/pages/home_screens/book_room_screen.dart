import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:geocoding/geocoding.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/empty_screen.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/active_bookings_screen.dart';
import 'package:imsmart_admin/pages/home_screens/preview_room_screen.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class BookRoomScreen extends StatefulWidget {
  final String propertyId;
  const BookRoomScreen({Key? key, required this.propertyId})
      : super(key: key);

  @override
  State<BookRoomScreen> createState() => _BookRoomScreenState();
}

class _BookRoomScreenState extends State<BookRoomScreen> {
  bool isExpandable = false;
  bool isLoading = false;
  RoomPropertyModel? roomProperty;

  late PropertyProvider provider;
  bool isLoadingProperty = false;
  _loadProperty () async {
    isLoadingProperty = true;
    if(mounted){
      setState(() {});
    }
    await provider.loadSingleApartment(context: context, propertyId: widget.propertyId);
    isLoadingProperty = false;
    roomProperty = provider.propertyModel;
    for(String a in roomProperty?.roomItems){
      items.add(a);
    }
    if(mounted){
      setState(() {});
    }
  }

  List<String> items = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = context.provideOnce<PropertyProvider>();
    _loadProperty();
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

          if(!isLoadingProperty && roomProperty == null) Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Center(child: EmptyScreen(title: "Apartment not found",)),
          ),

          if(!isLoadingProperty && roomProperty != null)
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
                    child: ImageLoader(
                      path: roomProperty?.imagePath,
                      width: 1.sw,
                      height: 375.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Positioned(
                    bottom: 90.h,
                    right: 20.w,
                    child: InkWell(
                      onTap: () async {
                        isLoading = true;
                        if(mounted){
                          setState(() {});
                        }
                        await _openMapWithAddress(
                            roomProperty?.location);
                        isLoading = false;
                        if(mounted){
                          setState(() {});
                        }
                      },
                      child: Container(
                        width: 100.w,
                        height: 40.h,
                        decoration: BoxDecoration(
                          color: Pallet.white,
                          borderRadius: BorderRadius.all(Radius.circular(24.r)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_pin, color: Pallet.grey, size: 20.w,),
                            SizedBox(width: 4.w,),
                            TextView(text: "Location", textStyle: body1TextStyle.copyWith(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Pallet.grey),)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

          if(!isLoadingProperty && roomProperty != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 580.h,
              child: Container(
                padding: EdgeInsets.symmetric(
                  // horizontal: setWidth(19),
                  vertical: setHeight(26),
                ),
                width: getWidth(context),
                // height: getHeight(context) / 1.29,
                decoration: BoxDecoration(
                    color: Pallet.bgColor,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(30.w), topRight: Radius.circular(30.w))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: setHeight(80),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(horizontal: setWidth(10)),
                          itemCount: roomProperty?.roomImages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.only(
                                right: index ==
                                    (roomProperty?.roomImages.length -
                                        1)
                                    ? setWidth(0)
                                    : setWidth(24),
                              ),
                              child: Container(
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                                child: ImageLoader(
                                  path: roomProperty?.roomImages[index],
                                  width: 80.w,
                                  height: 80.w,
                                  fit: BoxFit.cover,
                                  onTap: () {
                                    log("${roomProperty?.roomImages.length}");
                                    PageRouter.gotoWidget(
                                      PreviewRoomScreen(
                                        roomProperty: roomProperty!,
                                        index: index,
                                        imagePath:
                                        roomProperty?.roomImages[index],
                                      ),
                                      context,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),

                      SizedBox(height: 24.h),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: TextView(
                          text: "${roomProperty?.title}",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(22.sp),
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(24)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: InkWell(
                          onTap: () async {
                            isLoading = true;
                            if(mounted){
                              setState(() {});
                            }
                            await _openMapWithAddress(
                                roomProperty?.location);
                            isLoading = false;
                            if(mounted){
                              setState(() {});
                            }
                          },
                          child: Row(
                            children: [
                              ImageLoader(
                                path: AppAssets.locationOutline,
                                width: 12.38,
                                height: 15.75,
                              ),
                              SizedBox(width: setWidth(8)),
                              Expanded(
                                child: TextView(
                                  text: roomProperty?.location,
                                  textStyle: buttonTextStyle.copyWith(
                                    fontSize: setSp(12),
                                    fontWeight: FontWeight.w400,
                                    color: Pallet.black,
                                  ),
                                ),
                              ),
                              if (isLoading) ...[
                                SizedBox(width: setWidth(10)),
                                SizedBox(
                                  width: setWidth(20),
                                  height: setWidth(20),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Pallet.primaryColor,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: InkWell(
                          onTap: () async {
                            _launchDialer(roomProperty?.contact);
                          },
                          child: Row(
                            children: [
                              Icon(Icons.call, color:  Pallet.grey, size: 16.w,),
                              SizedBox(width: setWidth(8)),
                              Expanded(
                                child: TextView(
                                  text: "${roomProperty?.contact}",
                                  textStyle: buttonTextStyle.copyWith(
                                    fontSize: setSp(14),
                                    fontWeight: FontWeight.w400,
                                    color: Pallet.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: Row(
                          children: [
                            TextView(
                              text: "Caution fee: ",
                              textStyle: buttonTextStyle.copyWith(
                                fontSize: setSp(12),
                                fontWeight: FontWeight.w400,
                                color: Pallet.semiDarkGrayAccent,
                              ),
                            ),
                            TextView(
                              text: formatMoney(roomProperty?.cautionFee),
                              textStyle: buttonTextStyle.copyWith(
                                fontSize: setSp(16),
                                fontWeight: FontWeight.w600,
                                color: Pallet.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: TextView(
                          text: "Description",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(12)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: TextView(
                          text: roomProperty?.description,
                          maxLines: isExpandable ? null : 3,
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(12),
                            fontWeight: FontWeight.w400,
                            color: Pallet.semiDarkGrayAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(10)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: TextView(
                          onTap: () {
                            setState(() {
                              isExpandable = !isExpandable;
                            });
                          },
                          text: isExpandable ? "Read Less" : "Read More. . .",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(12),
                            fontWeight: FontWeight.w700,
                            color: Pallet.primaryColor,
                            // height: 0.25,
                          ),
                        ),
                      ),
                      SizedBox(height: setHeight(20)),
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: setWidth(19),
                        ),
                        child: TextView(
                          text: "Services and Facilities",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ),

                      SizedBox(height: 16.h),

                      Wrap(
                        spacing: 16.0, // Adjust the spacing between items
                        children: items.map((item) {
                          return Container(
                            width: MediaQuery.of(context).size.width / 2 - 24, // Adjust the width according to your needs
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                            child: Row(
                              children: [
                                Icon(Icons.check_circle, color: Pallet.blue, size: 16.w,),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: TextView(
                                    text: item,
                                    textStyle: buttonTextStyle.copyWith(
                                      fontSize: setSp(12),
                                      fontWeight: FontWeight.w400,
                                      color: Pallet.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),

                      SizedBox(height: 140.h),

                    ],
                  ),
                )
              ),
            ),

          if(roomProperty != null) Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 100.h,
            child: Container(
              width: 1.sw,
              height: 100.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              decoration: BoxDecoration(
                color: Pallet.white,
                boxShadow: [
                  BoxShadow(
                    color: Pallet.lightGray,
                    offset: Offset(0, -1), // Adjust the offset to position the shadow
                    blurRadius: 4,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextView(
                        text: "Price",
                        textStyle: buttonTextStyle.copyWith(
                          fontSize: setSp(12),
                          fontWeight: FontWeight.w700,
                          color: Pallet.lightGray,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: formatMoney(roomProperty?.amount, decimalDigits: 0),
                              style: buttonTextStyle.copyWith(
                                fontSize: setSp(18),
                                fontWeight: FontWeight.w700,
                                color: Pallet.black,
                              ),
                            ),
                            TextSpan(
                              text: '/night',
                              style: buttonTextStyle.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                color: Pallet.lightGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  CustomButtonWidget(
                    buttonText: "Book Now",
                    width: 132.w,
                    height: 50.h,
                    buttonColor: Pallet.primaryColor,
                    buttonTextStyle: body1TextStyle.copyWith(
                      color: Pallet.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                    onTap: () async {
                      PageRouter.gotoWidget(
                          ActiveBookingScreen(
                            propertyId: roomProperty?.id,
                          ),
                          context);
                    },
                  ),
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

  Future<void> _openMapWithAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);

      print(locations);

      if (locations.isNotEmpty) {
        double latitude = locations[0].latitude;
        double longitude = locations[0].longitude;

        await MapsLauncher.launchCoordinates(latitude, longitude);
        // await MapsLauncher.launchQuery(address);
      } else {
        AppDialog.showErrorDialog(context,
            message: 'Could not find location for the given address',
            onContinue: () {
          PageRouter.goBack(context);
        });
      }
    } on PlatformException catch (e) {
      log('Failed to get platform data: ${e.message}');
      String message = handlePlatformException(e);
      log(message);
      // AppDialog.showErrorDialog(context, message: 'Error: $message', onContinue: () {
      //   PageRouter.goBack(context);
      // });
    } catch (e) {
      AppDialog.showErrorDialog(context, message: 'Error: $e', onContinue: () {
        PageRouter.goBack(context);
      });
    }
  }

  void _launchDialer(String phoneNumber) async {
    try {
      final Uri phoneUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );
      if (await canLaunch(phoneUri.toString())) {
        await launch(phoneUri.toString());
      } else {
        throw 'Could not launch $phoneUri';
      }
    } on PlatformException catch (e) {
      log('Failed to open data: ${e.message}');
    } catch (e) {
      print(e);
    }
  }
}
