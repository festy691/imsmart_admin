import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class AccountDetailsCard extends StatelessWidget {
  final String accountDetailTitle;
  final String accountDetail;
  const AccountDetailsCard({
    required this.accountDetail,
    required this.accountDetailTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: getWidth(context),
      height: 50,
      padding: EdgeInsets.symmetric(
        horizontal: setWidth(24),
        vertical: setHeight(16),
      ),
      decoration: ShapeDecoration(
        color: Pallet.lightGrayAccent.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        children: [
          TextView(
            text: accountDetailTitle,
            textStyle: body1TextStyle.copyWith(
              color: Pallet.grayAccent,
              fontWeight: FontWeight.w700,
              fontSize: setSp(16),
              height: 0,
            ),
          ),
          //Spacer(),
          TextView(
            text: accountDetail,
            textStyle: body1TextStyle.copyWith(
              color: Pallet.grayAccent,
              fontSize: setSp(16),
              height: 0,
            ),
          ),
        ],
      ),
    );
  }
}
