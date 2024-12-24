import 'dart:ui';
import 'package:choose_input_chips/choose_input_chips.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class EditFormField extends StatelessWidget {
  EditFormField({
    this.label = '',
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.controller,
    this.onPasswordToggle,
    this.onTapInfo,
    this.initialValue,
    this.autoValidate = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.ignore = false,
    this.obscureText = false,
    this.isborderDecoration = true,
    this.onTapped,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusedColorBorder = Colors.white,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.decoration,
    this.iconColor,
    this.textCapitalization = TextCapitalization.none,
    this.key,
    this.showInfo = false,
    this.focusNode,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
  });

  TextCapitalization textCapitalization;
  String label;
  String? hint;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? iconColor;

  Widget? prefixWidget;
  Widget? suffixWidget;

  final FormFieldSetter<String>? onSaved;
  final Function(String)? onChanged;
  final FormFieldValidator<String>? validator;
  VoidCallback? onPasswordToggle;
  final AutovalidateMode? autoValidateMode;

  String? initialValue;
  TextEditingController? controller;
  FocusNode? focusNode;

  bool autocorrect;
  bool autoValidate;
  bool readOnly;
  bool showInfo;
  bool ignore;
  bool obscureText;
  bool isborderDecoration;

  // bool clickable;
  Function()? onTapped;

  // bool clickable;
  Function()? onTapInfo;

  TextInputType? keyboardType;
  int maxLines;
  int minLines;
  int? maxLength;
  var inputFormatters;
  Color focusedColorBorder;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  InputDecoration? decoration;
  FloatingLabelBehavior floatingLabelBehavior;
  Key? key;

  @override
  Widget build(BuildContext context) {
    focusedColorBorder = Theme.of(context).brightness == Brightness.dark
        ? Pallet.white
        : Pallet.grey;
    return InkWell(
      onTap: onTapped,
      child: IgnorePointer(
        ignoring: ignore,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: label,
                    textAlign: TextAlign.center,
                    textStyle: titleStyle.copyWith(
                      fontSize: ScreenUtil().setSp(14),
                      color: Pallet.white,
                      height: 1.43,
                    ),
                  ),
                  if (showInfo)
                    GestureDetector(
                      onTap: onTapInfo,
                      child: Icon(
                        Icons.info_outline,
                        size: setWidth(16),
                      ),
                    ),
                ],
              ),
            if (label.isNotEmpty)
              SizedBox(
                height: setHeight(8),
              ),
            Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: Container(
                decoration: ShapeDecoration(
                  color: Pallet.lightGrayAccent.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: TextFormField(
                  key: key,
                  keyboardType: keyboardType,
                  maxLines: maxLines,
                  minLines: minLines,
                  //enabled: enabled,
                  readOnly: readOnly,
                  textCapitalization: textCapitalization,
                  // autovalidate: autoValidate ?? false,
                  onSaved: onSaved,
                  validator: validator,
                  autocorrect: autocorrect,
                  initialValue: initialValue,
                  obscureText: obscureText,
                  onChanged: onChanged,
                  style: textStyle ??
                      body1TextStyle.copyWith(
                        color: Pallet.gray,
                        fontSize: setSp(16),
                        height: 1.57,
                      ),
                  controller: controller,
                  autovalidateMode: autoValidateMode,
                  inputFormatters: inputFormatters ??
                      [
                        LengthLimitingTextInputFormatter(maxLength ?? 100),
                      ],
                  decoration: decoration ??
                      InputDecoration(
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
                            body1TextStyle.copyWith(
                              color: Pallet.grayAccent,
                              fontSize: setSp(16),
                              height: 0,
                            ),
                        // labelText: "", //label,
                        isDense: true,
                        labelStyle: labelStyle ??
                            titleStyle.copyWith(
                              fontSize: setSp(16),
                              height: 1.43,
                              color: Pallet.white,
                            ),
                        prefixIcon: prefixIcon != null
                            ? IconButton(
                                onPressed: onPasswordToggle,
                                icon: Icon(
                                  prefixIcon,
                                  color:
                                      iconColor ?? Pallet.grey.withOpacity(0.7),
                                ))
                            : null,
                        suffixIcon: suffixIcon != null
                            ? IconButton(
                                onPressed: onPasswordToggle,
                                icon: Icon(
                                  suffixIcon,
                                  color:
                                      iconColor ?? Pallet.grey.withOpacity(0.7),
                                ))
                            : suffixWidget != null
                                ? suffixWidget
                                : null,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomChipInupt extends StatelessWidget {
  CustomChipInupt({
    this.label = '',
    this.hint = '',
    this.prefixIcon,
    this.suffixIcon,
    this.suffixWidget,
    this.prefixWidget,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.autoValidateMode = AutovalidateMode.onUserInteraction,
    this.onPasswordToggle,
    this.onTapInfo,
    this.initialValue,
    this.autoValidate = false,
    this.autocorrect = true,
    this.readOnly = false,
    this.ignore = false,
    this.obscureText = false,
    this.isborderDecoration = true,
    this.onTapped,
    this.keyboardType,
    this.maxLines = 1,
    this.minLines = 1,
    this.maxLength,
    this.inputFormatters,
    this.focusedColorBorder = Colors.white,
    this.labelStyle,
    this.hintStyle,
    this.textStyle,
    this.decoration,
    this.iconColor,
    this.textCapitalization = TextCapitalization.none,
    this.key,
    this.showInfo = false,
    this.focusNode,
    required this.inputList,
    required this.initialList,
    this.floatingLabelBehavior = FloatingLabelBehavior.never,
  });

  TextCapitalization textCapitalization;
  String label;
  String hint;
  IconData? prefixIcon;
  IconData? suffixIcon;
  Color? iconColor;

  Widget? prefixWidget;
  Widget? suffixWidget;

  final FormFieldSetter<String>? onSaved;
  final Function(List<dynamic>)? onChanged;
  final FormFieldValidator<String>? validator;
  VoidCallback? onPasswordToggle;
  final AutovalidateMode? autoValidateMode;

  String? initialValue;
  FocusNode? focusNode;

  bool autocorrect;
  bool autoValidate;
  bool readOnly;
  bool showInfo;
  bool ignore;
  bool obscureText;
  bool isborderDecoration;

  List<dynamic> inputList;
  List<dynamic> initialList;

  // bool clickable;
  Function()? onTapped;

  // bool clickable;
  Function()? onTapInfo;

  TextInputType? keyboardType;
  int maxLines;
  int minLines;
  int? maxLength;
  var inputFormatters;

  Color focusedColorBorder;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  InputDecoration? decoration;
  FloatingLabelBehavior floatingLabelBehavior;
  Key? key;

  @override
  Widget build(BuildContext context) {
    focusedColorBorder = Theme.of(context).brightness == Brightness.dark
        ? Pallet.white
        : Pallet.grey;
    return InkWell(
      onTap: onTapped,
      child: IgnorePointer(
        ignoring: ignore,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (label.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextView(
                    text: label,
                    textAlign: TextAlign.center,
                    textStyle: titleStyle.copyWith(
                      fontSize: ScreenUtil().setSp(14),
                      color: Pallet.white,
                      height: 1.43,
                    ),
                  ),
                  if (showInfo)
                    GestureDetector(
                      onTap: onTapInfo,
                      child: Icon(
                        Icons.info_outline,
                        size: setWidth(16),
                      ),
                    ),
                ],
              ),
            if (label.isNotEmpty)
              SizedBox(
                height: setHeight(8),
              ),
            Theme(
              data: Theme.of(context).copyWith(splashColor: Colors.transparent),
              child: Container(
                decoration: ShapeDecoration(
                  color: Pallet.lightGrayAccent.withOpacity(0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: ChipsInput(
                  initialValue: initialList,
                  decoration: decoration ??
                      InputDecoration(
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
                        //contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24.0),
                        hintText: hint,
                        hintStyle: hintStyle ??
                            GoogleFonts.poppins(
                                color: Pallet.grey.withOpacity(0.7)),
                        labelText: "", //label,
                        isDense: true,
                        labelStyle: labelStyle ??
                            GoogleFonts.poppins(
                                color: Pallet.grey.withOpacity(0.7),
                                fontSize: setSp(14)),
                        prefixIcon: prefixIcon != null
                            ? IconButton(
                                onPressed: onPasswordToggle,
                                icon: Icon(prefixIcon))
                            : null,
                        suffixIcon: suffixIcon != null
                            ? IconButton(
                                onPressed: onPasswordToggle,
                                icon: Icon(
                                  suffixIcon,
                                  color:
                                      iconColor ?? Pallet.grey.withOpacity(0.7),
                                ))
                            : null,
                      ),
                  maxChips: 20,
                  findSuggestions: (String query) {
                    if (query.length != 0) {
                      var lowercaseQuery = query.toLowerCase();
                      return inputList.where((profile) {
                        return profile
                            .toLowerCase()
                            .contains(query.toLowerCase());
                      }).toList(growable: false)
                        ..sort((a, b) => a
                            .toLowerCase()
                            .indexOf(lowercaseQuery)
                            .compareTo(
                                b.toLowerCase().indexOf(lowercaseQuery)));
                    } else {
                      return const <String>[];
                    }
                  },
                  onChanged: onChanged!,
                  chipBuilder: (context, state, profile) {
                    return InputChip(
                      key: ObjectKey(profile),
                      label: Text(profile.toString()),
                      onDeleted: () => state.deleteChip(profile),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    );
                  },
                  suggestionBuilder: (context, state, profile) {
                    return ListTile(
                      key: ObjectKey(profile),
                      title: Text(profile.toString()),
                      onTap: () => state.selectSuggestion(profile),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
