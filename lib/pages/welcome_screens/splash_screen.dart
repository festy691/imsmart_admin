import 'dart:async';

import 'package:flutter/material.dart';
import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
import 'package:imsmart_admin/core/my_providers/property_provider.dart';
import 'package:imsmart_admin/core/utils/app_assets.dart';
import 'package:imsmart_admin/core/utils/constants.dart';
import 'package:imsmart_admin/core/utils/page_router.dart';
import 'package:imsmart_admin/core/utils/pallet.dart';
import 'package:imsmart_admin/core/widget/image_loader.dart';
import 'package:imsmart_admin/pages/auth_screens/login_screen.dart';
import 'package:imsmart_admin/pages/welcome_screens/onboarding_screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(seconds: 3),
      () => PageRouter.gotoWidget(
        LoginScreen(),
        context,
        clearStack: true,
      ),
    );
    super.initState();

    context.provideOnce<PropertyProvider>().loadAllApartments(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallet.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: ImageLoader(
              path: AppAssets.imSmartLogoBig,
              width: setWidth(400),
              height: setHeight(400),
            ),
          ),
        ],
      ),
    );
  }
}
