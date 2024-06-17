import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class CustomDropdownInput<T> extends StatelessWidget {
  final String? hintText;
  final List<T> options;
  final T? value;
  final String Function(T?)? getLabel;
  final void Function(T?)? onChanged;
  String? label;
  String? hint;
  Widget? prefixWidget;
  Widget? suffixWidget;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  Color? focusedColorBorder;
  double? width;
  bool disabled;

  CustomDropdownInput(
      {this.hintText = 'Please select an Option',
      this.options = const [],
      this.value,
      this.getLabel,
      this.onChanged,
      this.label,
      this.hint,
      this.disabled = false,
      this.prefixWidget,
      this.suffixWidget,
      this.labelStyle,
      this.hintStyle,
      this.textStyle,
      this.width,
      this.focusedColorBorder});

  @override
  Widget build(BuildContext context) {
    focusedColorBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        TextView(
          text: label ?? "",
          textAlign: TextAlign.center,
          textStyle: titleStyle.copyWith(
            fontSize: ScreenUtil().setSp(14),
            color: Pallet.white,
            height: 1.43,
          ),
        ),
        SizedBox(
          height: setHeight(8),
        ),
        Theme(
          data: Theme.of(context).copyWith(splashColor: Colors.transparent),
          child: IgnorePointer(
            ignoring: disabled,
            child: Container(
              decoration: ShapeDecoration(
                color: disabled
                    ? Pallet.grey.withOpacity(0.4)
                    : Pallet.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: FormField<T>(
                builder: (FormFieldState<T> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: setWidth(24), vertical: setHeight(16)),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      ),
                      // floatingLabelBehavior: FloatingLabelBehavior.always,
                      hintText: hint,
                      hintStyle: hintStyle ??
                          captionStyle.copyWith(
                            color: Pallet.white.withOpacity(0.4),
                            fontSize: setSp(16),
                            height: 1.57,
                          ),
                      // labelText: "", //label,
                      isDense: true,
                      labelStyle: labelStyle ??
                          titleStyle.copyWith(
                            fontSize: setSp(16),
                            height: 1.43,
                            color: Pallet.white,
                          ),
                    ),
                    isEmpty: value == null || value == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<T>(
                        icon: suffixWidget,
                        dropdownColor: Pallet.colorPrimaryDark,
                        iconSize: ScreenUtil().setHeight(25),
                        iconEnabledColor: Pallet.hintColor,
                        value: value,
                        isDense: true,
                        items: options.map((T value) {
                          return DropdownMenuItem<T>(
                            value: value,
                            child: Container(
                              width: width != null
                                  ? width
                                  : getWidth(context) * .6,
                              child: Text(
                                getLabel!(value),
                                style: captionStyle.copyWith(
                                  color: Pallet.white,
                                  fontSize: setSp(16),
                                  height: 1.57,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: onChanged,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class StateDropdownInput<T> extends StatelessWidget {
  final String? hintText;
  final List<T> options;
  final T? value;
  final String Function(T?)? getLabel;
  final void Function(T?)? onChanged;
  String? label;
  String? hint;
  Widget? prefixWidget;
  Widget? suffixWidget;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  Color? focusedColorBorder;
  double? width;

  StateDropdownInput(
      {this.hintText = 'Please select an Option',
      this.options = const [],
      this.value,
      this.getLabel,
      this.onChanged,
      this.label,
      this.hint,
      this.prefixWidget,
      this.suffixWidget,
      this.labelStyle,
      this.hintStyle,
      this.textStyle,
      this.width,
      this.focusedColorBorder});

  @override
  Widget build(BuildContext context) {
    focusedColorBorder = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.grey;
    return Container(
      height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Pallet.grey.withOpacity(.5), width: 1.5)),
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintText: hint,
              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              errorStyle: TextStyle(
                  color: Colors.deepOrange,
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
              border: InputBorder.none,
              hintStyle: hintStyle,
              labelText: label,
              labelStyle: labelStyle ??
                  TextStyle(
                      color: isLightMode(context)
                          ? Pallet.black.withOpacity(.8)
                          : Pallet.black.withOpacity(.8)),
            ),
            isEmpty: value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                icon: suffixWidget,
                iconSize: ScreenUtil().setHeight(25),
                iconEnabledColor: Pallet.grey,
                value: value,
                isDense: true,
                items: options.map((T value) {
                  return DropdownMenuItem<T>(
                    value: value,
                    child: SizedBox(
                      width:
                          width != null ? width : ScreenUtil().screenWidth * .7,
                      child: Text(
                        getLabel!(value),
                        style: TextStyle(color: Pallet.black),
                        // maxLines: 2,
                        // overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
              ),
            ),
          );
        },
      ),
    );
  }
}
