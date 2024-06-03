import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timezone/timezone.dart' as tz;

const channelId = "timer_completion_notification";
const channelName = "Timer Completion Notification";
const notificationId = 1;

Future<void> scheduleTimerNotification(
    String title, Duration duration, WidgetRef ref) async {
  final plugin = FlutterLocalNotificationsPlugin();
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings();

  const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: initializationSettingsDarwin);

  await plugin.initialize(
    settings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) async {
      if (kDebugMode) {
        print("onDidReceiveNotificationResponse");
      }
    },
  );

  final scheduledDate = tz.TZDateTime.now(tz.UTC).add(duration);

  if (kDebugMode) {
    print(scheduledDate);
  }

  NotificationDetails notificationDetails = const NotificationDetails(
      android: AndroidNotificationDetails(channelId, channelName,
          importance: Importance.high,
          priority: Priority.high,
          icon: "@drawable/notification_icon"),
      iOS: DarwinNotificationDetails());

  await plugin.zonedSchedule(
    notificationId,
    title,
    null,
    scheduledDate,
    notificationDetails,
    androidAllowWhileIdle: true,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
  );
}
