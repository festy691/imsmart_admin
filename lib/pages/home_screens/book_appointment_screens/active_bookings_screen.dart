import 'package:flutter/gestures.dart';
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
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/pages/home_screens/book_appointment_screens/reservation_screen.dart';
import 'package:imsmart_admin/pages/home_screens/privacy_policy_screen.dart';
import 'package:imsmart_admin/pages/home_screens/terms_service_screen.dart';
import 'package:provider/provider.dart';

import 'appointment_calendar_screens.dart';

class ActiveBookingScreen extends StatefulWidget {
  final String propertyId;
  const ActiveBookingScreen({Key? key, required this.propertyId})
      : super(key: key);

  @override
  State<ActiveBookingScreen> createState() => _ActiveBookingScreenState();
}

class _ActiveBookingScreenState extends State<ActiveBookingScreen> {
  bool isChecked = false;
  List<BookApartmentModel> bookings = [];
  late PropertyProvider provider;
  bool isLoadingProperty = false;
  List<DateTime> _markedDates = [];

  _loadProperty() async {
    isLoadingProperty = true;
    if (mounted) {
      setState(() {});
    }
    await provider.loadAllBookings(
        context: context, propertyId: widget.propertyId, load: false);
    isLoadingProperty = false;
    bookings = provider.bookings;
    for (BookApartmentModel b in bookings) {
      DateTime startDate = DateTime.parse(b.checkinDate);
      DateTime endDate = DateTime.parse(b.checkoutDate);

      int _daysBetween = daysBetween(startDate, endDate);

      for (int i = 0; i < _daysBetween; i++) {
        DateTime bDate = startDate.add(Duration(days: i));
        DateTime markDate = DateTime(bDate.year, bDate.month, bDate.day);
        _markedDates.add(markDate);
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    provider = context.provideOnce<PropertyProvider>();
    _loadProperty();
  }

  @override
  Widget build(BuildContext context) {
    PropertyProvider _provider = Provider.of<PropertyProvider>(context);
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
          text: "Bookings",
          textStyle: body1TextStyle.copyWith(
            fontSize: setSp(20),
            fontWeight: FontWeight.w600,
            color: Pallet.white,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: setWidth(20), vertical: setHeight(32)),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButtonWidget(
                        width: 150.w,
                        buttonText: "Click to check Availability",
                        buttonColor: Pallet.primaryColor,
                        buttonTextColor: Pallet.whiteColor,
                        onTap: () {
                          openAppointCalenderSheet();
                        },
                      ),
                    ],
                  ),

                  SizedBox(height: 24.h),

                  // AppointmentCalendar(markedDates: _markedDates),
                  Container(
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: ImageLoader(
                      path: provider.propertyModel?.imagePath,
                      width: getHeight(context),
                      height: setHeight(239.5),
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 24.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Title",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(12.sp),
                            fontWeight: FontWeight.w400,
                            color: Pallet.grey,
                          ),
                        ),
                        TextView(
                          text: "${provider.propertyModel?.title}",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(16),
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Pallet.lightGrey,
                  ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Price",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(12.sp),
                            fontWeight: FontWeight.w400,
                            color: Pallet.grey,
                          ),
                        ),
                        TextView(
                          text: formatMoney(provider.propertyModel?.amount,
                              decimalDigits: 0),
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(16),
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Divider(
                    thickness: 1,
                    color: Pallet.lightGrey,
                  ),

                  SizedBox(height: 12.h),

                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextView(
                          text: "Caution fee",
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(12.sp),
                            fontWeight: FontWeight.w400,
                            color: Pallet.grey,
                          ),
                        ),
                        TextView(
                          text: formatMoney(provider.propertyModel?.cautionFee,
                              decimalDigits: 0),
                          textStyle: buttonTextStyle.copyWith(
                            fontSize: setSp(16),
                            fontWeight: FontWeight.w700,
                            color: Pallet.black,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),
                ],
              ),
            ),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = !isChecked;
                        isChecked = value!;
                      });
                    }),
                Expanded(
                  child: RichText(
                    text: new TextSpan(
                      text: 'I accept the  ',
                      style: captionStyle.copyWith(
                        fontSize: setSp(12),
                        color: Pallet.darkGrayAccent,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'Terms and Conditions',
                            style: captionStyle.copyWith(
                              fontSize: setSp(12),
                              fontWeight: FontWeight.w600,
                              color: Pallet.transparentBlue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                termsAndCondition();
                              }),
                        TextSpan(
                          text: ' and ',
                          style: captionStyle.copyWith(
                            fontSize: setSp(12),
                            color: Pallet.darkGrayAccent,
                          ),
                        ),
                        TextSpan(
                            text: 'Privacy Policy',
                            style: captionStyle.copyWith(
                              fontSize: setSp(12),
                              fontWeight: FontWeight.w600,
                              color: Pallet.transparentBlue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                privacyPolicy();
                              }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            CustomButtonWidget(
              onTap: () {
                PageRouter.gotoWidget(
                    ReservationScreen(
                      roomPropertyModel: provider.propertyModel!,
                    ),
                    context);
              },
              buttonText: "Continue",
              width: getWidth(context),
              height: setHeight(56),
              disabled: !isChecked,
              buttonColor: Pallet.primaryColor,
              buttonTextStyle: body1TextStyle.copyWith(
                color: Pallet.white,
                fontSize: setSp(18),
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 12.h),
          ],
        ),
      ),
    );
  }

  void openAppointCalenderSheet() {
    BottomSheets.showSheet<String>(
      context,
      child: Column(
        children: [
          if (isLoadingProperty)
            Center(
              child: ImageLoader(
                path: AppAssets.loaderLottie,
                width: 120.w,
                height: 120.h,
              ),
            ),
          AppointmentCalendar(markedDates: _markedDates),
        ],
      ),
    );
  }

  termsAndCondition() {
    PageRouter.gotoWidget(TermsServiceScreen(), context);
  }

  privacyPolicy() {
    PageRouter.gotoWidget(PrivacyPolicyScreen(), context);
  }
}
