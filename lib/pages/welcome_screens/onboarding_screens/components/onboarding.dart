import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/background_widget.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:imsmart_admin/pages/welcome_screens/onboarding_screens/components/onboarding_background.dart';

class OnBoarding extends StatefulWidget {
  final String imagePath;
  final String title;
  final String heading;
  final String headingContd;
  final String caption;
  const OnBoarding({
    Key? key,
    required this.title,
    required this.imagePath,
    required this.heading,
    required this.headingContd,
    required this.caption,
  }) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    return OnBoardingBackground(
      image: widget.imagePath,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: setHeight(500)),
          TextView(
            text: widget.title,
            textStyle: captionStyle.copyWith(
              color: Pallet.lightPrimaryColor,
              fontSize: 40,
              height: 1.5,
            ),
          ),
          TextView(
            text: widget.heading,
            textAlign: TextAlign.center,
            textStyle: heading2.copyWith(
              height: 1,
            ),
          ),
          TextView(
            text: widget.headingContd,
            textAlign: TextAlign.center,
            textStyle: heading2.copyWith(
              color: Pallet.lightPrimaryColor,
              fontSize: setSp(60),
              // fontWeight: FontWeight.w700,
              height: 1,
            ),
          ),
          SizedBox(height: setHeight(16)),
          TextView(
            text: widget.caption,
            textAlign: TextAlign.center,
            textStyle: heading2.copyWith(
              color: Pallet.white,
              fontSize: setSp(14),
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}
