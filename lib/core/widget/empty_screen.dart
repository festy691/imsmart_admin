import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyScreen extends StatelessWidget {
  EmptyScreen({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: setHeight(64),
          ),
          ImageLoader(
            path: AppAssets.noData,
            width: getWidth(context) * 0.5,
            height: getWidth(context) * 0.5,
            fit: BoxFit.fitWidth,
          ),
          TextView(
            text: title,
            textStyle: titleStyle.copyWith(fontSize: setSp(16)),
          ),
        ],
      ),
    );
  }
}
