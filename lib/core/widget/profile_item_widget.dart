import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget profileActionItemWidget(
        {required String title,
        required String assets,
        required VoidCallback onTap,
        bool isLogout = false}) =>
    InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              assets,
              height: ScreenUtil().setHeight(44),
              width: ScreenUtil().setWidth(44),
              fit: BoxFit.cover,
            ),
            SizedBox(
              width: ScreenUtil().setWidth(12),
            ),
            Expanded(
                child: TextView(
              text: title,
              textColor: isLogout ? Colors.red : null,
            )),
            Icon(Icons.keyboard_arrow_right)
          ],
        ),
      ),
    );

Widget receiptItemWidget({required String title, required String desc}) =>
    Column(
      children: [
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextView(
              text: title,
              textAlign: TextAlign.left,
            ),
            Expanded(
                child: TextView(
              text: desc,
              textColor: Pallet.colorPrimary,
              textAlign: TextAlign.right,
              textStyle: TextStyle(fontFamily: "sans"),
            )),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(12),
        ),
        Divider(
          thickness: 1,
          color: Pallet.grey.withOpacity(0.7),
        ),
      ],
    );
