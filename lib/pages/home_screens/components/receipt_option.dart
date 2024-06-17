import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class ReceiptOption extends StatelessWidget {
  final String title;
  final String caption;
  const ReceiptOption({
    Key? key,
    required this.title,
    required this.caption,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextView(
          text: title,
          textStyle: captionStyle.copyWith(
            fontSize: setSp(12),
            color: Pallet.lightGrey
          ),
        ),
        Spacer(),
        TextView(
          text: caption,
          textStyle: captionStyle.copyWith(
            fontSize: setSp(14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
