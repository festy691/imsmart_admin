import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomBottomSheetsWidget extends StatelessWidget {
  String title;
  String? desc;
  String? buttonText;
  VoidCallback? onTap;
  bool showCancel;
  CustomBottomSheetsWidget(
      {required this.title,
      this.desc,
      this.buttonText,
      this.onTap,
      this.showCancel = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ImageLoader(
                    path: AppAssets.comingSoon,
                    width: ScreenUtil().setWidth(48),
                    height: ScreenUtil().setHeight(48),
                  ),
                  SizedBox(height: 24),
                  TextView(
                    text: title,
                    textAlign: TextAlign.center,
                    textStyle:
                        titleStyle.copyWith(fontSize: ScreenUtil().setSp(18)),
                  ),
                  SizedBox(height: 24),
                  TextView(
                    text: desc!,
                    textAlign: TextAlign.center,
                    textStyle: GoogleFonts.firaSans(
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomButtonWidget(
                    buttonText: buttonText!,
                    width: getWidth(context),
                    onTap: onTap!,
                  ),
                  Visibility(
                    visible: showCancel,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 24),
                        CustomOutlinedButtonWidget(
                          buttonText: 'Cancel',
                          width: getWidth(context),
                          onTap: () => PageRouter.goBack(context),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomSheetsWidget extends StatelessWidget {
  String desc;
  String? buttonText;
  VoidCallback? onTap;
  CustomSheetsWidget({required this.desc, this.buttonText, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
      ),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ImageLoader(
                    path: AppAssets.comingSoon,
                    width: ScreenUtil().setWidth(48),
                    height: ScreenUtil().setHeight(48),
                  ),
                  SizedBox(height: 24),
                  TextView(
                    text: desc,
                    textAlign: TextAlign.center,
                    textStyle:
                        titleStyle.copyWith(fontSize: ScreenUtil().setSp(20)),
                  ),
                  SizedBox(height: 24),
                  CustomButtonWidget(
                    buttonText: buttonText!,
                    width: getWidth(context),
                    onTap: onTap!,
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
