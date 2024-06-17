import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_button.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccessScreen extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback? onShare;
  final VoidCallback? onSaveToContact;
  String title;
  String desc;
  String subDesc;
  String buttonText;

  SuccessScreen(
      {required this.onTap,
      required this.title,
      required this.buttonText,
      this.desc = '',
      this.subDesc = '',
      this.onShare,
      this.onSaveToContact});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          backgroundColor: Pallet.colorPrimaryDark,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  Container(
                    child: ImageLoader(
                      path: AppAssets.completionLottie,
                      width: ScreenUtil().screenWidth,
                      height: ScreenUtil().screenHeight * .5,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextView(
                    text: title,
                    textStyle: GoogleFonts.firaSans(
                      color: Pallet.white,
                      fontSize: ScreenUtil().setSp(24),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  TextView(
                    text: desc,
                    textColor: Pallet.white,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Visibility(
                    visible: subDesc.isNotEmpty,
                    child: Wrap(
                      children: [
                        SizedBox(
                          height: 4,
                        ),
                        TextView(
                          text: subDesc,
                          textColor: Pallet.white,
                          textStyle: TextStyle(
                              fontSize: ScreenUtil().setSp(12),
                              color: Pallet.white),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Visibility(
                    visible: onShare != null && onSaveToContact != null,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: onSaveToContact,
                          child: Row(
                            children: [
                              Icon(
                                Icons.star_border_outlined,
                                color: Pallet.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextView(
                                text: 'Save beneficiary',
                                textColor: Pallet.white,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 74,
                        ),
                        InkWell(
                          onTap: onShare,
                          child: Row(
                            children: [
                              Icon(
                                Icons.share_outlined,
                                color: Pallet.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TextView(
                                text: 'Share',
                                textColor: Pallet.white,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  CustomButtonWidget(
                    width: getWidth(context),
                    buttonColor: Pallet.white,
                    buttonTextColor: Pallet.colorPrimary,
                    buttonText: buttonText,
                    onTap: onTap,
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(53),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
