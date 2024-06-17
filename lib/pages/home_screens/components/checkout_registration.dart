import 'package:flutter/material.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';

import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/edit_form_widget.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class CheckOutRegistration extends StatefulWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController addressController;
  final TextEditingController referralController;
  final String checkOutDate;
  final String checkInDate;
  final TextEditingController countryController;
  final TextEditingController phoneNumberController;
  final firstNameKey;
  final lastNameKey;
  final emailKey;
  final addressKey;
  final checkOutDateKey;
  final checkInDateKey;
  final countryKey;
  final phoneNumberKey;
  final VoidCallback onCheckOutDateTap;
  final VoidCallback onCheckInDateTap;
  bool isCheckInDateSelected;
  bool isCheckOutDateSelected;
  CheckOutRegistration({
    Key? key,
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.addressController,
    required this.referralController,
    required this.checkOutDate,
    required this.checkInDate,
    required this.countryController,
    required this.phoneNumberController,
    required this.firstNameKey,
    required this.lastNameKey,
    required this.emailKey,
    required this.addressKey,
    required this.checkOutDateKey,
    required this.checkInDateKey,
    required this.countryKey,
    required this.phoneNumberKey,
    required this.onCheckOutDateTap,
    required this.onCheckInDateTap,
    this.isCheckInDateSelected = false,
    this.isCheckOutDateSelected = false,
  }) : super(key: key);

  @override
  State<CheckOutRegistration> createState() => _CheckOutRegistrationState();
}

class _CheckOutRegistrationState extends State<CheckOutRegistration> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: setHeight(5)),
        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.firstNameKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "First Name",
            controller: widget.firstNameController,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.lastNameKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "Last Name",
            controller: widget.lastNameController,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.emailKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "Email Address",
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.phoneNumberKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "Mobile Phone",
            controller: widget.phoneNumberController,
            keyboardType: TextInputType.number,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.addressKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "Address",
            controller: widget.addressController,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        InkWell(
          onTap: widget.onCheckInDateTap,
          child: ShakeMe(
            // 4. pass the GlobalKey as an argument
            key: widget.checkInDateKey,
            // 5. configure the animation parameters
            shakeCount: 3,
            shakeOffset: 10,
            shakeDuration: const Duration(milliseconds: 500),
            child: Container(
              width: getWidth(context),
              // height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: setWidth(24),
                vertical: setHeight(16),
              ),
              decoration: ShapeDecoration(
                color: Pallet.lightGrayAccent.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: TextView(
                text: widget.checkInDate,
                textStyle: body1TextStyle.copyWith(
                  color: widget.isCheckInDateSelected
                      ? Pallet.gray
                      : Pallet.grayAccent,
                  fontSize: setSp(16),
                  height: 0,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: setHeight(18)),

        InkWell(
          onTap: widget.onCheckOutDateTap,
          child: ShakeMe(
            // 4. pass the GlobalKey as an argument
            key: widget.checkOutDateKey,
            // 5. configure the animation parameters
            shakeCount: 3,
            shakeOffset: 10,
            shakeDuration: const Duration(milliseconds: 500),
            child: Container(
              width: getWidth(context),
              // height: 50,
              padding: EdgeInsets.symmetric(
                horizontal: setWidth(24),
                vertical: setHeight(16),
              ),
              decoration: ShapeDecoration(
                color: Pallet.lightGrayAccent.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: TextView(
                text: widget.checkOutDate,
                textStyle: body1TextStyle.copyWith(
                  color: widget.isCheckOutDateSelected
                      ? Pallet.gray
                      : Pallet.grayAccent,
                  fontSize: setSp(16),
                  height: 0,
                ),
              ),
            ),
          ),
        ),

        SizedBox(height: setHeight(18)),

        ShakeMe(
          // 4. pass the GlobalKey as an argument
          key: widget.countryKey,
          // 5. configure the animation parameters
          shakeCount: 3,
          shakeOffset: 10,
          shakeDuration: const Duration(milliseconds: 500),
          child: EditFormField(
            hint: "Country",
            controller: widget.countryController,
            keyboardType: TextInputType.text,
            onChanged: (text) {
              if (mounted) {
                setState(() {});
              }
            },
          ),
        ),

        SizedBox(height: setHeight(18)),

        EditFormField(
          hint: "Referral Code (Optional)",
          controller: widget.referralController,
          keyboardType: TextInputType.text,
          onChanged: (text) {
            if (mounted) {
              setState(() {});
            }
          },
        ),

        SizedBox(height: setHeight(18)),
      ],
    );
  }
}
