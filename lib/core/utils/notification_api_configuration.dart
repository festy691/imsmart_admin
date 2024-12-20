import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationAPI {
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();
  static String darwinNotificationCategoryPlain = 'plainCategory';

  static final DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
    requestAlertPermission: false,
    requestBadgePermission: false,
    requestSoundPermission: false,
  );

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max),
        iOS: DarwinNotificationDetails(
            categoryIdentifier: darwinNotificationCategoryPlain));
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // ignore: avoid_print
    log('notification(${notificationResponse.id}) action tapped: '
        '${notificationResponse.actionId} with'
        ' payload: ${notificationResponse.payload}');
    if (notificationResponse.input?.isNotEmpty ?? false) {
      // ignore: avoid_print
      log('notification action tapped with input: ${notificationResponse.input}');
    }
  }

  static Future init({bool isScheduled = false}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(
        android: android, iOS: initializationSettingsDarwin);

    await _notification.initialize(
      settings,
      onDidReceiveNotificationResponse:
          (NotificationResponse notificationResponse) {
        /*switch (notificationResponse.notificationResponseType) {
          case NotificationResponseType.selectedNotification:
            onNotifications.add(notificationResponse.payload);
            break;
          case NotificationResponseType.selectedNotificationAction:
            if (notificationResponse.actionId == navigationActionId) {
              onNotifications.add(notificationResponse.payload);
            }
            break;
        }*/
        onNotifications.add(notificationResponse.payload);
      },
      //onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  static Future showNotification(
          {required int id,
          String? title,
          String? body,
          String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetails(),
          payload: payload);
}
