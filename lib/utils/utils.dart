import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Utils {
  static Utils shared = Utils();
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
}
