import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationAPI{
  static final _notification = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
        android: AndroidNotificationDetails(
            'channel id',
            'channel name',
            'channel description',
            importance: Importance.max
        ),
        iOS: IOSNotificationDetails()
    );
  }

  static Future init({bool isScheduled = false}) async {
    final ios = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: ios);

    await _notification.initialize(
        settings,
        onSelectNotification: (payload) async {
          onNotifications.add(payload);
        }
    );
  }

  static Future showNotification({required int id, String? title, String? body, String? payload}) async =>
      _notification.show(id, title, body, await _notificationDetails(), payload: payload);
}
