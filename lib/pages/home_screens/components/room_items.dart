import 'package:flutter/material.dart';

import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class RoomItem extends StatelessWidget {
  final String imagePath;
  final String caption;
  bool? hasBackgroundColor;
  RoomItem({
    Key? key,
    required this.imagePath,
    required this.caption,
    this.hasBackgroundColor = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: (hasBackgroundColor ?? false)
          ? EdgeInsets.symmetric(
              horizontal: setWidth(12),
              vertical: setHeight(4),
            )
          : EdgeInsets.zero,
      decoration: ShapeDecoration(
        color: (hasBackgroundColor ?? false)
            ? Pallet.primaryColor
            : Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          imagePath.isEmpty
              ? Icon(
                  Icons.check,
                  color: Pallet.grey,
                )
              : ImageLoader(
                  path: imagePath,
                  width: 20,
                  height: 20,
                  dColor: Pallet.lightGrayAccent,
                ),
          SizedBox(width:
          (hasBackgroundColor ?? false) ? setWidth(8) : setWidth(13.5),
          ),
          TextView(
            text: caption,
            textStyle: (hasBackgroundColor ?? false)
                ? buttonTextStyle.copyWith(
                    fontSize: setSp(12),
                    fontWeight: FontWeight.w500,
                    color: Pallet.black,
                  )
                : body1TextStyle.copyWith(
                    fontSize: setSp(14),
                    fontWeight: FontWeight.w400,
                    color: Pallet.darkGrayAccent,
                  ),
          ),
        ],
      ),
    );
  }
}
