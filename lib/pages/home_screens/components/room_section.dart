import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/models/room_property_model.dart';
import 'package:imsmart_admin/models/room_section_model.dart';

class RoomSection extends StatelessWidget {
  final String imagePath;
  final VoidCallback onTap;
  final bool isSelected;
  const RoomSection({
    Key? key,
    required this.imagePath,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: setHeight(10),
          horizontal: setWidth(10),
        ),
        width: setWidth(130),
        decoration: ShapeDecoration(
          color: Pallet.black.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 2,
              color: isSelected
                  ? Pallet.transparentBlue.withOpacity(0.49)
                  : Pallet.transparent,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Container(
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: ImageLoader(
            path: imagePath,
            width: 90.w,
            height: 90.w,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
