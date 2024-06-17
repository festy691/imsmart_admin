// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
// import 'package:flutter/material.dart';
// import 'package:imsmart_admin/core/extensions/extended_build_context.dart';
// import 'package:imsmart_admin/core/my_providers/auth_provider.dart';
// import 'package:imsmart_admin/core/services/notification_service.dart';
// import 'package:imsmart_admin/core/utils/blink_dialog.dart';
// import 'package:imsmart_admin/models/api_response.dart';
// import 'package:imsmart_admin/models/notification_model.dart';
// import 'package:imsmart_admin/models/transaction_model.dart';
//
// class NotificationProvider with ChangeNotifier {
//   NotificationService _notificationService;
//   NotificationProvider(NotificationService notificationService)
//       : _notificationService = notificationService;
//
//   final _loadingKey = GlobalKey<State>();
//
//   List<NotificationModel> allNotifications = [];
//
//   void setNotificationList(List<NotificationModel> list) {
//     allNotifications = list;
//     notifyListeners();
//   }
//
//   Future<APIResponse> loadAllNotifications(
//       {required BuildContext context, bool load = false}) async {
//     try {
//       if (load) {
//         LoadingDialog.showLoading(context, _loadingKey);
//       }
//       APIResponse result = await _notificationService.getNotifications(
//           userId: context.provideOnce<AuthProvider>().getMe.id);
//       if (!result.error) {
//         List<NotificationModel> _list = [];
//         for (var c in result.data) {
//           NotificationModel model = NotificationModel.fromJson(c);
//           _list.add(model);
//         }
//         setNotificationList(_list);
//       }
//       if (load) {
//         LoadingDialog.hideLoading(_loadingKey);
//       }
//       return result;
//     } catch (e, s) {
//       if (load) {
//         LoadingDialog.hideLoading(_loadingKey);
//       }
//       await FirebaseCrashlytics.instance
//           .recordError(e, s, reason: 'Fetch all Notifications');
//       return APIResponse(error: true, message: e.toString());
//     }
//   }
//
//   Future<APIResponse> readNotification(
//       {required BuildContext context,
//       bool load = false,
//       required String notificationId}) async {
//     try {
//       if (load) {
//         LoadingDialog.showLoading(context, _loadingKey);
//       }
//       APIResponse result = await _notificationService.readNotification(
//           notificationId: notificationId);
//       if (!result.error) {
//         await loadAllNotifications(context: context);
//       }
//       if (load) {
//         LoadingDialog.hideLoading(_loadingKey);
//       }
//       return result;
//     } catch (e, s) {
//       if (load) {
//         LoadingDialog.hideLoading(_loadingKey);
//       }
//       await FirebaseCrashlytics.instance
//           .recordError(e, s, reason: 'Read Notification');
//       return APIResponse(error: true, message: e.toString());
//     }
//   }
// }
