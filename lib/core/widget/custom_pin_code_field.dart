import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

//What would happen if i use the context
//of this one instead of the context of the
//the class that would use it?

class CustomPinCodeField extends StatefulWidget {
  final int pinLength;
  final BuildContext appContext;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  const CustomPinCodeField({
    Key? key,
    required this.pinLength,
    required this.appContext,
    this.controller,
    this.focusNode,
  }) : super(key: key);

  @override
  State<CustomPinCodeField> createState() => _CustomPinCodeFieldState();
}

class _CustomPinCodeFieldState extends State<CustomPinCodeField> {
  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      length: widget.pinLength,
      obscureText: false,
      controller: widget.controller,
      textStyle: titleStyle.copyWith(
        color: Pallet.white,
        fontSize: setSp(16),
      ),
      // GoogleFonts.poppins(color: Pallet.black.withOpacity(0.7), fontSize: setSp(16)),
      animationType: AnimationType.none,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.all(Radius.circular(setWidth(8))),
        fieldHeight: setWidth(70),
        fieldWidth: setWidth(50),
        activeFillColor: Pallet.blueDark,
        activeColor: Pallet.blueDark,
        inactiveColor: Pallet.blueDark,
        borderWidth: 0,
        inactiveFillColor: Pallet.blueDark,
        selectedColor: Pallet.blueDark,
        selectedFillColor: Pallet.blueDark,
      ),
      keyboardType: TextInputType.none,
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      cursorColor: Pallet.white.withOpacity(.8),
      focusNode: widget.focusNode,
      onCompleted: (v) {
        //otp = v;
        //validate();
      },
      onChanged: (v) {},
      beforeTextPaste: (text) {
        return true;
      },
      appContext: widget.appContext,
    );
  }
}
