import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';

import 'text_views.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double? height;
  final double radius;
  final String? font;
  final num fontSize;
  final Color? buttonTextColor;
  final TextStyle? buttonTextStyle;
  Color? buttonColor;
  Color? borderColor;
  final double? width;
  bool disabled;

  CustomButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.height,
      this.radius = 8,
      this.width,
      this.fontSize = 16,
      this.buttonTextColor,
      this.borderColor,
      this.buttonTextStyle,
      this.disabled = false,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: IgnorePointer(
        ignoring: disabled,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: disabled == true
                ? Pallet.lightGrey.withOpacity(0.1)
                : buttonColor ?? Pallet.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(setWidth(10)),
            ),
          ),
          child: TextView(
            text: buttonText,
            textAlign: TextAlign.center,
            textStyle: buttonTextStyle ??
                TextStyle(
                    fontFamily: fontFamily,
                    color: buttonTextColor,
                    fontSize: setSp(fontSize),
                    fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomOutlinedButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double fontSize;
  final String? font;
  final Color? buttonTextColor;
  Color? buttonColor;
  Color? borderColor;
  final double width;

  CustomOutlinedButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.height = 50,
      this.radius = 8,
      this.width = 50,
      this.fontSize = 16,
      this.buttonTextColor,
      this.borderColor,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: OutlinedButton(
        onPressed: onTap,
        style: OutlinedButton.styleFrom(
            backgroundColor: borderColor ?? Pallet.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            side: BorderSide(color: borderColor ?? Pallet.colorPrimaryDark)),
        child: TextView(
          text: buttonText,
          textAlign: TextAlign.center,
          textStyle: TextStyle(
              fontFamily: fontFamily,
              fontSize: ScreenUtil().setSp(fontSize),
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomOutlinedButton2Widget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double radius;
  final double fontSize;
  final String? font;
  final String? icon;
  final Color? buttonTextColor;
  Color? buttonColor;
  Color? borderColor;
  final double width;

  CustomOutlinedButton2Widget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.icon,
      this.height = 50,
      this.radius = 8,
      this.width = 50,
      this.fontSize = 16,
      this.buttonTextColor,
      this.borderColor,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Pallet.black, width: 1),
            borderRadius: BorderRadius.circular(10.0)),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: setWidth(54)),
              ImageLoader(
                path: icon,
                width: setWidth(20),
                height: setHeight(20),
              ),
              Expanded(
                child: SizedBox(
                  child: TextView(
                    text: buttonText,
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                        fontFamily: fontFamily,
                        fontSize: ScreenUtil().setSp(fontSize),
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(width: setWidth(54)),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomSmallButtonWidget extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final double height;
  final double radius;
  bool disabled;
  final String? font;
  final TextStyle? buttonTextStyle;
  final Color? buttonTextColor;
  Color? buttonColor;
  Color? borderColor;
  final double width;

  CustomSmallButtonWidget(
      {Key? key,
      required this.buttonText,
      required this.onTap,
      this.font,
      this.buttonTextStyle,
      this.height = 30,
      this.radius = 8,
      this.width = 60,
      this.buttonTextColor,
      this.borderColor,
      this.disabled = false,
      this.buttonColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: IgnorePointer(
        ignoring: disabled,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: disabled == true
                ? Pallet.lightGrey.withOpacity(0.4)
                : buttonColor ?? Pallet.colorPrimaryDark,
            elevation: 0.5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          child: TextView(
              text: buttonText,
              textAlign: TextAlign.center,
              textStyle: buttonTextStyle ??
                  titleStyle.copyWith(
                    fontSize: setSp(12),
                    color: buttonTextColor,
                  )
              // TextStyle(
              //   fontFamily: fontFamily,
              //   color: buttonTextColor,
              //   fontSize: setSp(12),
              //   fontWeight: FontWeight.w700,
              // ),
              ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  CustomIconButton({
    Key? key,
    this.title,
    this.isSvg = false,
    this.isText = false,
    required this.icon,
    required this.onTap,
    this.buttonColor = Pallet.colorPrimaryDark,
    this.textColor = Pallet.black,
    this.borderRadius,
    this.width = 150,
    this.height = 40,
    this.iconWidth,
    this.iconHeight,
    this.isOutlined = false,
  }) : super(key: key);

  String? title;
  bool isSvg;
  bool isText;
  String icon;
  Function onTap;
  Color buttonColor;
  Color? textColor;
  double? borderRadius;
  num width;
  num height;
  num? iconWidth;
  num? iconHeight;
  bool isOutlined;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 8),
        width: setWidth(width),
        height: setHeight(height),
        decoration: isOutlined
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(setWidth(16)),
                border: Border.all(color: buttonColor, width: 0.5))
            : BoxDecoration(
                color: buttonColor,
                borderRadius:
                    BorderRadius.circular(borderRadius ?? setWidth(16))),
        child: isText
            ?
            //           ? SizedBox()
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isSvg
                      ? SvgPicture.asset(
                          icon,
                          width: setWidth(iconWidth ?? 22),
                          height: setWidth(iconHeight ?? 22),
                        )
                      : ImageLoader(
                          path: icon,
                          width: setWidth(iconWidth ?? 22),
                          height: setWidth(iconHeight ?? 22),
                        ),
                  if (title != null) ...[
                    SizedBox(height: setWidth(8)),
                    // title != null
                    //     ?
                    TextView(
                        text: title!,
                        textAlign: TextAlign.start,
                        textStyle: captionStyle.copyWith(
                          fontSize: setSp(14),
                          color: textColor,
                        )
                        // GoogleFonts.roboto(
                        //   fontSize: setSp(14),
                        //   color: textColor,
                        //   fontWeight: FontWeight.w500,
                        // ),
                        )
                    // : SizedBox(),
                  ],
                ],
              )
            : isSvg
                ? SvgPicture.asset(icon)
                : ImageLoader(
                    path: icon,
                    width: setWidth(22),
                    height: setWidth(22),
                  ),
      ),
    );
  }
}
