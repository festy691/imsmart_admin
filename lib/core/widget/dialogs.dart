import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
// import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/auth_provider.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppDialog {
  AppDialog._();

  defaultDialog(String title, Widget content,
      {bool isDismissible = false, Widget? confirm, Widget? cancel}) {
    return Get.defaultDialog(
      title: title,
      content: content,
      cancel: cancel ?? null,
      confirm: confirm ?? null,
      barrierDismissible: isDismissible,
      radius: 10,
    );
  }

  customisedDialog(
    Widget widget, {
    bool isDismissible = false,
  }) {
    return Get.dialog(widget, barrierDismissible: isDismissible);
  }

  static showInfoDialog(BuildContext context,
      {required String message, required Function onContinue}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  setWidth(16),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              setWidth(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Pallet.blue,
                  size: setWidth(24),
                ),
                SizedBox(width: setWidth(14)),
                TextView(
                  text: "Info",
                  textStyle: GoogleFonts.roboto(
                      fontSize: setSp(18),
                      color: Pallet.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: setHeight(132),
              width: setWidth(332),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    height: 0.5,
                    color: Pallet.grey,
                  ),
                  SizedBox(height: setHeight(10)),
                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(
                        fontSize: setSp(16),
                        color: Pallet.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButtonWidget(
                          buttonText: "Continue",
                          height: setHeight(38),
                          width: setWidth(114),
                          onTap: () {
                            onContinue();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showConfirmationDialog(BuildContext context,
      {String title = "Info",
      required String message,
      required Function onContinue}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  setWidth(16),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              setWidth(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Pallet.blue,
                  size: setWidth(24),
                ),
                SizedBox(width: setWidth(14)),
                TextView(
                  text: title,
                  textStyle: GoogleFonts.roboto(
                      fontSize: setSp(18),
                      color: Pallet.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: setHeight(132),
              width: setWidth(332),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    height: 0.5,
                    color: Pallet.grey,
                  ),
                  SizedBox(height: setHeight(10)),
                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(
                        fontSize: setSp(16),
                        color: Pallet.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButtonWidget(
                          buttonText: "Close",
                          height: setHeight(38),
                          width: setWidth(114),
                          onTap: () {
                            PageRouter.goBack(context);
                          }),
                      CustomOutlinedButtonWidget(
                          buttonText: "Continue",
                          height: setHeight(38),
                          width: setWidth(114),
                          onTap: () {
                            onContinue();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showSuccessDialog(BuildContext context,
      {String title = "Successful",
      required String message,
      required Function onContinue}) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  setWidth(16),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              setWidth(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle,
                  color: Pallet.green,
                  size: setWidth(24),
                ),
                SizedBox(width: setWidth(14)),
                TextView(
                  text: title,
                  textStyle: GoogleFonts.roboto(
                      fontSize: setSp(18),
                      color: Pallet.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: setHeight(132),
              width: setWidth(332),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    height: 0.5,
                    color: Pallet.grey,
                  ),
                  SizedBox(height: setHeight(10)),
                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(
                        fontSize: setSp(16),
                        color: Pallet.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButtonWidget(
                          buttonText: "Continue",
                          height: setHeight(38),
                          width: setWidth(114),
                          onTap: () {
                            onContinue();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static showErrorDialog(BuildContext context,
      {required String message, required Function onContinue}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  setWidth(16),
                ),
              ),
            ),
            contentPadding: EdgeInsets.all(
              setWidth(20),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.cancel,
                  color: Pallet.red,
                  size: setWidth(24),
                ),
                SizedBox(width: setWidth(14)),
                TextView(
                  text: "Failed",
                  textStyle: GoogleFonts.roboto(
                      fontSize: setSp(18),
                      color: Pallet.black,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            content: Container(
              //height: setHeight(132),
              width: setWidth(332),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Divider(
                    height: 0.5,
                    color: Pallet.grey,
                  ),
                  SizedBox(height: setHeight(10)),
                  TextView(
                    text: message,
                    textStyle: GoogleFonts.roboto(
                        fontSize: setSp(16),
                        color: Pallet.black.withOpacity(0.8),
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomOutlinedButtonWidget(
                          buttonText: "Continue",
                          height: setHeight(38),
                          width: setWidth(114),
                          onTap: () {
                            onContinue();
                          }),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  static YYDialog showAuthDialog(BuildContext context, {String title = "Two factor code", required Function onContinue}) {
    final _otpController = TextEditingController();

    return YYDialog().build(context)
      ..width = setWidth(372)
    //..height = setHeight(448)
      ..borderRadius = setWidth(16)
      ..widget(
        StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Padding(
                padding: EdgeInsets.all(setWidth(24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextView(
                      text: title,
                      textStyle: GoogleFonts.roboto(fontSize: setSp(18), color: Pallet.black, fontWeight: FontWeight.w500),
                    ),

                    SizedBox(height: setHeight(18)),

                    Divider(height: 1, color: Pallet.grey,),

                    SizedBox(height: setHeight(16)),

                    TextView(
                      text: "Copy the code generated on your Authenticator app, note that the code changes within a few seconds.",
                      textStyle: GoogleFonts.roboto(fontSize: setSp(18), color: Pallet.black, fontWeight: FontWeight.w500),
                    ),

                    SizedBox(height: setHeight(24)),

                    TextView(
                      text: "This serves as a second layer protection on your account to prevent unauthorized access.",
                      textStyle: GoogleFonts.roboto(fontSize: setSp(14), color: Pallet.black, fontWeight: FontWeight.w400),
                    ),

                    SizedBox(height: setHeight(30)),

                    TextView(
                      text: "Enter your 2-Fa code",
                      textStyle: GoogleFonts.roboto(fontSize: setSp(16), color: Pallet.black, fontWeight: FontWeight.w500),
                    ),

                    SizedBox(height: setHeight(18)),

                    Center(
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        controller: _otpController,
                        textStyle: GoogleFonts.poppins(color: Pallet.black.withOpacity(0.7), fontSize: setSp(16)),
                        animationType: AnimationType.none,
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(setWidth(10)),
                          fieldHeight: setHeight(50),
                          fieldWidth: setWidth(40),
                          activeFillColor: Pallet.transparent,
                          activeColor: Pallet.grey.withOpacity(.6),
                          inactiveColor: Pallet.grey.withOpacity(.2),
                          inactiveFillColor: Pallet.transparent,
                          selectedColor: Pallet.grey.withOpacity(.6),
                          selectedFillColor: Pallet.transparent,
                        ),
                        keyboardType: TextInputType.number,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,
                        cursorColor: Pallet.grey.withOpacity(.8),
                        onCompleted: (v) {
                          //otp = v;
                          //validate();
                        },
                        onChanged: (v) {

                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                        appContext: context,
                      ),
                    ),

                    SizedBox(height: setHeight(50)),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButtonWidget(
                            width: setWidth(150),
                            height: setHeight(48),
                            buttonText: "Proceed",
                            onTap:() async{
                              var result = await context.provideOnce<AuthProvider>().verifyTwoFa(context: context, token: _otpController.text);
                              if (result.error) return;
                              onContinue();
                            }
                        ),

                        CustomOutlinedButtonWidget(
                            width: setWidth(150),
                            height: setHeight(48),
                            buttonText: "Cancel",
                            onTap:(){
                              PageRouter.goBack(context);
                            }
                        ),
                      ],
                    ),

                  ],
                ),
              );
            }
        ),
      )
      ..show();
  }

}
