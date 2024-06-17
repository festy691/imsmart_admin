import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/utils.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/book_apartment_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';

class Checkout extends StatefulWidget {
  final RoomPropertyModel roomPropertyModel;
  final BookApartmentModel bookApartmentModel;
  const Checkout({
    Key? key,
    required this.roomPropertyModel,
    required this.bookApartmentModel,
  }) : super(key: key);

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  int totalDays = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime selectDateIn =
        DateTime.parse(widget.bookApartmentModel.checkinDate);
    DateTime selectDateOut =
        DateTime.parse(widget.bookApartmentModel.checkoutDate);
    totalDays = (selectDateIn.difference(selectDateOut).inDays).abs();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 48.h),
        Container(
          width: 1.sw,
          height: 200.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 200.h,
                child: ImageLoader(
                  path: widget.roomPropertyModel.imagePath,
                  height: 200.h,
                  width: 1.sw,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                left: 12.w,
                right: 12.w,
                bottom: 12.h,
                child: TextView(
                  text: widget.roomPropertyModel.title.toString().toUpperCase(),
                  textStyle: body1TextStyle.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w700,
                    color: Pallet.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 32.h),
        _listItem(
            title: "Room(s)",
            subtitle: "${widget.roomPropertyModel.roomNumber}"),
        _listItem(
            title: "Toilet(s)", subtitle: "${widget.roomPropertyModel.toilet}"),
        _listItem(title: "Night(s)", subtitle: "$totalDays"),
        _listItem(
            title: "Check-in date",
            subtitle:
                "${formatDate(widget.bookApartmentModel.checkinDate, format: "MMM dd, yyyy")}"),
        _listItem(
            title: "Check-out date",
            subtitle:
                "${formatDate(widget.bookApartmentModel.checkoutDate, format: "MMM dd, yyyy")}"),
        _listItem(
            title: "Amount",
            subtitle:
                "${formatMoney(widget.roomPropertyModel.amount * totalDays, decimalDigits: 0)}"),
        _listItem(
            title: "Caution fee",
            subtitle:
                "${formatMoney(widget.roomPropertyModel.cautionFee, decimalDigits: 0)}"),
        if ((widget.bookApartmentModel.discountAmount ?? 0) > 0)
          _listItem(
              title: "Discount amount",
              subtitle:
                  "${formatMoney(widget.bookApartmentModel.discountAmount, decimalDigits: 0)}"),
        _listItem(
            title: "Total",
            subtitle:
                "${formatMoney(widget.bookApartmentModel.transactionAmount, decimalDigits: 0)}"),
        SizedBox(height: setHeight(80)),
      ],
    );
  }

  Widget _listItem({required String title, required String subtitle}) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextView(
              text: title,
              textStyle: buttonTextStyle.copyWith(
                fontSize: setSp(12.sp),
                fontWeight: FontWeight.w400,
                color: Pallet.grey,
              ),
            ),
            TextView(
              text: subtitle,
              textStyle: buttonTextStyle.copyWith(
                fontSize: setSp(16),
                fontWeight: FontWeight.w700,
                color: Pallet.black,
              ),
            ),
          ],
        ),
        Divider(
          thickness: 1,
          color: Pallet.lightGrey,
        ),
        SizedBox(height: 12.h),
      ],
    );
  }
}
