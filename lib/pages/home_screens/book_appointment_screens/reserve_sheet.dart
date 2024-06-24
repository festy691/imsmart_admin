import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

typedef OnSelected = Function(int);
class ReserveSheet extends StatelessWidget {
  final OnSelected onSelected;
  const ReserveSheet({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 400.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
        color: Pallet.white,
      ),
      child: Column(
        children: [
          TextView(
            text: "Reservations",
            textStyle: body1TextStyle.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: Pallet.black,
            ),
          ),

          SizedBox(height: 48.h,),

          CustomButtonWidget(
            buttonText: "Make payment",
            width: 1.sw,
            height: 56.h,
            buttonColor: Pallet.primaryColor,
            onTap: (){
              onSelected(0);
              PageRouter.goBack(context);
            },
          ),

          SizedBox(height: 24.h,),

          CustomOutlinedButtonWidget(
            buttonText: "Skip payment",
            width: 1.sw,
            height: 56.h,
            buttonColor: Pallet.primaryColor,
            onTap: (){
              onSelected(1);
              //PageRouter.goBack(context);
            },
          ),
        ],
      ),
    );
  }
}
