import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.primaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Pallet.primaryColor,
        leading: ImageLoader(
          path: AppAssets.arrowBack,
          dColor: Pallet.white,
          width: 24.w,
          height: 16.h,
          onTap: () {
            PageRouter.goBack(context);
          },
        ),
        title: TextView(
          text: "About Us",
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
                TextView(
                  text:
                      "IMSMART company was founded in 2023 by two friends (NEWTON AND SMART) who shared a common vision: to create a business that would make a positive impact in the world. IMSMART started out small. At first, we operated with a building in Akwa Ibom with just a handful of employees. But we were determined to succeed, and we poured all of our time and energy into growing IMSMART. We were zealous about giving our clients the best services they could ever find and making sure they feel at home whenever they check-in. We went all out looking for means to reinvent IMSMART to meet the taste of clients by making sure, we use the best when it comes to contemporary designs for home.",
                  textAlign: TextAlign.justify,
                  textStyle: captionStyle.copyWith(
                    fontSize: setSp(14),
                    height: 3,
                  ),
                ),
                SizedBox(height: setHeight(30)),
                TextView(
                  text: "OUR MISSION",
                  textAlign: TextAlign.center,
                  textStyle: captionStyle.copyWith(
                    fontSize: setSp(23),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextView(
                  text:
                      "From the beginning, our company has been driven by a sense of purpose. We believe that businesses have a responsibility to make a positive impact in the world, and we're committed to doing our part. That's why we donate a portion of our profits to charity, and why we prioritize sustainability in everything we do.",
                  textAlign: TextAlign.justify,
                  textStyle: captionStyle.copyWith(
                    fontSize: setSp(14),
                    height: 3,
                  ),
                ),
                SizedBox(height: setHeight(30)),
                TextView(
                  text: "OUR FUTURE",
                  textAlign: TextAlign.center,
                  textStyle: captionStyle.copyWith(
                    fontSize: setSp(23),
                    fontWeight: FontWeight.w800,
                  ),
                ),
                TextView(
                  text:
                      "We're excited about what's in store for our company in the years to come. We know that we'll face challenges and setbacks along the way, but we're confident that we can overcome them with hard work, determination, and a commitment to our values. We look forward to continuing to grow and make a positive impact in the world",
                  textAlign: TextAlign.justify,
                  textStyle: captionStyle.copyWith(
                    fontSize: setSp(14),
                    height: 3,
                  ),
                ),
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
