// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:imsmart_admin/core/utils/constants.dart';
// import 'package:imsmart_admin/core/utils/page_router.dart';
// import 'package:imsmart_admin/pages/home_screens/home_screen.dart';
//
// class DynamicLinkService {
//   factory DynamicLinkService() => instance;
//
//   DynamicLinkService._();
//
//   static final DynamicLinkService instance = DynamicLinkService._();
//   Future<void> retrieveDynamicLink(BuildContext context) async {
//     try {
//       final PendingDynamicLinkData? data =
//           await FirebaseDynamicLinks.instance.getInitialLink();
//       final Uri? deepLink = data?.link;
//
//       if (deepLink != null) {
//         PageRouter.gotoWidget(HomeScreen(), context);
//       }
//
//       FirebaseDynamicLinks.instance.onLink
//           .listen((PendingDynamicLinkData? dynamicLink) async {
//         if (dynamicLink != null) {
//           final Uri? dLink = dynamicLink.link;
//           PageRouter.gotoWidget(HomeScreen(), context);
//         }
//       }).onError((error) {
//         print('onLink error');
//         print(error.message);
//       });
//     } catch (e) {
//       print(e.toString());
//     }
//   }
// }
//
// DynamicLinkService dynamicLinkService = getIt.get<DynamicLinkService>();
