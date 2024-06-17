import 'package:imsmart_admin/core/utils/app_assets.dart';
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

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BackgroundWidget(
        hasAppBar: false,
        body: SafeArea(
          child: Container(
            width: getWidth(context),
            height: getHeight(context),
            padding: EdgeInsets.symmetric(horizontal: setWidth(24)),
            child: Column(
              children: [
                SizedBox(
                  height: setHeight(30),
                ),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          PageRouter.goBack(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Pallet.white,
                          size: setWidth(22),
                        )),
                  ],
                ),
                SizedBox(
                  height: setHeight(72),
                ),
                Center(
                  child: ImageLoader(
                    path: AppAssets.comingSoon,
                    width: setWidth(300),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
