import 'package:flutter/material.dart';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/dialogs.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class PaymentOptionSheet extends StatelessWidget {
  final VoidCallback onTapWithTransfer;
  final VoidCallback onTapWithCard;
  const PaymentOptionSheet({
    Key? key,
    required this.onTapWithTransfer,
    required this.onTapWithCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: setHeight(430),
      width: getWidth(context),
      padding: EdgeInsets.all(setWidth(30)),
      decoration: BoxDecoration(
          color: Pallet.darkCream,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(setWidth(16)),
              topRight: Radius.circular(setWidth(16)))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _optionsCard(
            context,
            title: "Pay with Bank Transfer",
            onTap: onTapWithTransfer,
          ),
          SizedBox(height: setHeight(20)),
          _optionsCard(
            context,
            title: "Pay with Card",
            // subtitle: "Unavailable",
            onTap: () {
              // return AppDialog.showInfoDialog(context,
              //   message: "This payment option is currently unavailable",
              //   onContinue: () {
              //     PageRouter.goBack(context);
              //   }
              // );
              onTapWithCard();
            },
          ),
        ],
      ),
    );
  }

  Widget _optionsCard(BuildContext context,
      {required String title, String? subtitle, required Function onTap}) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: setHeight(80),
        width: getWidth(context),
        padding: EdgeInsets.symmetric(horizontal: setWidth(24)),
        decoration: BoxDecoration(
          color: Pallet.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(setWidth(16))),
        ),
        child: Row(
          children: [
            ImageLoader(
              path: AppAssets.atm,
              width: setWidth(32),
              height: setHeight(32),
            ),
            SizedBox(width: setWidth(20)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextView(
                  text: title,
                  textStyle: titleStyle.copyWith(
                      fontSize: setSp(16),
                      height: 1.50,
                      fontFamily: fontFamily),
                ),
                if (subtitle != null) ...[
                  SizedBox(height: setHeight(2)),
                  TextView(
                    text: subtitle,
                    textStyle: titleStyle.copyWith(
                        fontSize: setSp(12),
                        color: Pallet.dividerColor,
                        height: 1.50,
                        fontFamily: fontFamily),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
