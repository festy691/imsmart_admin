import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:url_launcher/url_launcher_string.dart';

class TermsServiceScreen extends StatelessWidget {
  const TermsServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.primaryColor,
      appBar: AppBar(
        elevation: 0,
        leading: ImageLoader(
          path: AppAssets.arrowBack,
          dColor: Pallet.white,
          width: 24.w,
          height: 16.h,
          onTap: () {
            PageRouter.goBack(context);
          },
        ),
        backgroundColor: Pallet.primaryColor,
        title: TextView(
          text: "Terms of service",
          textStyle: body1TextStyle.copyWith(
            fontSize: setSp(20),
            fontWeight: FontWeight.w600,
            color: Pallet.white,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(height: setHeight(15)),
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: setWidth(25)),
              children: [
                SizedBox(height: setHeight(15)),
                HtmlWidget(termsOfService,
                  // all other parameters are optional, a few notable params:

                  // specify custom styling for an element
                  // see supported inline styling below
                  customStylesBuilder: (element) {
                    if (element.classes.contains('foo')) {
                      return {'color': 'red'};
                    }

                    return null;
                  },

                  // this callback will be triggered when user taps a link
                  onTapUrl: (url) {
                    try {
                      launchUrlString(url);
                    } catch (e){
                      print(e.toString());
                    }
                    return true;
                  },

                  // select the render mode for HTML body
                  // by default, a simple `Column` is rendered
                  // consider using `ListView` or `SliverList` for better performance
                  renderMode: RenderMode.column,

                  // set the default styling for text
                  textStyle: TextStyle(fontSize: 14, color: Pallet.white),
                ),
                SizedBox(height: setHeight(30)),
              ],
            ),
          ),
          ImageLoader(
            path: AppAssets.imSmartLogoTransparent,
            width: setWidth(288),
            height: setHeight(105),
          ),
        ],
      ),
    );
  }
}
