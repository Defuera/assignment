import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationClass {
  final int id;
  final String title;
  final String body;
  final String payload;

  NotificationClass({this.id, this.body, this.payload, this.title});
}

class AlarmManager {
  static NotificationAppLaunchDetails notifLaunch;
  static final FlutterLocalNotificationsPlugin notifsPlugin = FlutterLocalNotificationsPlugin();

  static final initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('ic_steps'),
    iOS: IOSInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
        onDidReceiveLocalNotification: (int id, String title, String body, String payload) async {
          // didReceiveLocalNotificationSubject.add(NotificationClass(id: id, title: title, body: body, payload: payload));
        }),
  );

  static Future<void> init() async {
    notifLaunch = await notifsPlugin.getNotificationAppLaunchDetails();
    await initNotifications();
    requestIOSPermissions();
  }

  static Future<void> initNotifications() async {
    await notifsPlugin.initialize(initializationSettings, onSelectNotification: (String payload) async {});
    print("Notifications initialised successfully");
  }

  static void requestIOSPermissions() {
    notifsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<void> scheduleNotification({
    String title,
    String body,
    DateTime scheduledTime,
  }) async {
    final androidSpecifics = AndroidNotificationDetails(
      'fastic', // This specifies the ID of the Notification
      'Fastic', // This specifies the name of the notification channel
      '8pm Reminder', //This specifies the description of the channel
      icon: 'ic_steps',
    );
    final iOSSpecifics = IOSNotificationDetails();
    final details = NotificationDetails(android: androidSpecifics, iOS: iOSSpecifics);
    await notifsPlugin.zonedSchedule(
      0,
      title,
      "Scheduled notification",
      scheduledTime,
      details,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.wallClockTime,
      matchDateTimeComponents: DateTimeComponents.time,
    ); // This literally schedules the notification
  }

  Future<void> removeScheduledNotifications() async {
    await notifsPlugin.cancelAll();
  }
}
