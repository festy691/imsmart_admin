import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/utils/app_theme.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/utils/password_checker.dart';
import 'package:imsmart_admin/core/widget/text_views.dart';

class PasswordValidatorDisplay extends StatelessWidget {
  const PasswordValidatorDisplay({
    Key? key,
    required this.passwordChecker,
  }) : super(key: key);

  final ValueNotifier<PasswordChecker> passwordChecker;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<PasswordChecker>(
      valueListenable: passwordChecker,
      builder: (context, state, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Wrap(
                spacing: getWidth(context),
                // runSpacing: 8.0,
                children: [
                  if (!state.hasUpperCase)
                    _CheckItems(
                      title: '*Upper case',
                      isActive: state.hasUpperCase,
                    ),
                  if (!state.hasLowerCase)
                    _CheckItems(
                      isActive: state.hasLowerCase,
                      title: '*Lower case',
                    ),
                  if (!state.hasNumber)
                    _CheckItems(
                      isActive: state.hasNumber,
                      title: '*Digit',
                    ),
                  if (!state.hasSpecialCharacter)
                    _CheckItems(
                      isActive: state.hasSpecialCharacter,
                      title: '*Special character',
                    ),
                  if (!state.moreThanLen8)
                    _CheckItems(
                      isActive: state.moreThanLen8,
                      title: '*8 characters',
                    ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}

class _CheckItems extends StatelessWidget {
  const _CheckItems({
    Key? key,
    required this.title,
    required this.isActive,
  }) : super(key: key);
  final String title;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextView(
            text: title,
            textStyle: captionStyle.copyWith(
              fontSize: setSp(12),
              color: Pallet.white,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }
}
