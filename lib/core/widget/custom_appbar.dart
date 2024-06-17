import 'dart:io';

import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar appBar(BuildContext context,
    {List<Widget>? actions, Widget? leadingWidget, Widget? titleWidget}) {
  return AppBar(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Pallet.white,
    title: titleWidget,
    toolbarHeight: ScreenUtil().setHeight(50),
    leading: leadingWidget ??
        IconButton(
            color: Pallet.black,
            iconSize: setWidth(24),
            onPressed: () => PageRouter.goBack(context),
            icon: Icon(
              Icons.arrow_back,
              size: setWidth(24),
              color: Pallet.black,
            )),
    actions: actions,
  );
}
