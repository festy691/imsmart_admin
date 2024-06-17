import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/pages/home_screens/home_screen.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/receipt_screen.dart';

class ReservationSuccessfulScreen extends StatefulWidget {
  final RoomPropertyModel roomPropertyModel;
  final BookApartmentModel bookApartmentModel;
  const ReservationSuccessfulScreen({
    Key? key,
    required this.roomPropertyModel,
    required this.bookApartmentModel,
  }) : super(key: key);

  @override
  State<ReservationSuccessfulScreen> createState() =>
      _ReservationSuccessfulScreenState();
}

class _ReservationSuccessfulScreenState
    extends State<ReservationSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.darkCream,
      body: Column(
        // clipBehavior: Clip.none,
        children: [
          Container(
            height: getHeight(context) / 1.1,
            decoration: ShapeDecoration(
              color: Pallet.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 120.h),
                      ImageLoader(
                        path: AppAssets.completeIcon,
                        width: 150.w,
                        height: 150.w,
                      ),

                      SizedBox(height: 44.h),

                      Align(
                        alignment: Alignment.center,
                        child: TextView(
                          text: "Booking\nConfirmed",
                          textStyle: body2TextStyle.copyWith(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            color: Pallet.darkCream,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(height: 48.h),

                      Align(
                        alignment: Alignment.center,
                        child: TextView(
                          text: "Download Booking Receipt",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(14),
                            fontWeight: FontWeight.w600,
                            color: Pallet.darkCream,
                            decoration: TextDecoration.underline,
                            // height: 0.11,
                          ),
                          onTap: () {
                            PageRouter.gotoWidget(
                                ReceiptScreen(
                                  roomPropertyModel: widget.roomPropertyModel,
                                  bookApartmentModel: widget.bookApartmentModel,
                                ),
                                context);
                          },
                        ),
                      ),

                      SizedBox(height: 64.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: CustomButtonWidget(
                          height: 56.h,
                          width: 1.sw,
                          buttonColor: Pallet.white,
                          buttonTextColor: Pallet.black,
                          buttonText: "Go to home screen",
                          onTap: (){
                            PageRouter.gotoWidget(HomeScreen(), context,
                                clearStack: true);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: setHeight(10)),
          TextView(
            text: "Check your mail for booking details",
            textStyle: buttonTextStyle.copyWith(
              fontSize: setSp(14),
              fontWeight: FontWeight.w500,
              color: Pallet.black,
            ),
          ),
        ],
      ),
    );
  }
}
