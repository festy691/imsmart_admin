import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget body;
  final List<Widget>? actions;
  final Widget? leadingWidget;
  final Widget? titleWidget;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool hasPadding;
  final bool hasAppBar;
  final Color backgroundColor;

  const BackgroundWidget({
    Key? key,
    required this.body,
    this.actions,
    this.hasPadding = false,
    this.leadingWidget,
    this.titleWidget,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.hasAppBar = true,
    this.backgroundColor = Pallet.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: hasAppBar
          ? appBar(
              context,
              actions: actions,
              leadingWidget: leadingWidget,
              titleWidget: titleWidget,
            )
          : null,
      floatingActionButton: floatingActionButton,
      body: Container(
        width: getWidth(context),
        height: getHeight(context),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.00, -1.00),
            end: Alignment(0, 1),
            colors: [
              Pallet.white,
              Pallet.white,
            ],
          ),
        ),
        padding: hasPadding
            ? EdgeInsets.only(left: 20, right: 20, bottom: 16)
            : EdgeInsets.only(top: 0),
        child: body,
      ),
      bottomNavigationBar: bottomNavigationBar,
    );
  }
}
