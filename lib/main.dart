import 'package:fcmpoc/components/home/home.dart';
import 'package:fcmpoc/components/second/second.dart';
import 'package:fcmpoc/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Utils.shared.channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Utils.shared.flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  await Utils.shared.flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(Utils.shared.channel);
  // const AndroidInitializationSettings initializationSettingsAndroid =
  //     AndroidInitializationSettings('app_icon');
  // final IOSInitializationSettings initializationSettingsIOS =
  //     IOSInitializationSettings(
  //         onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  // final MacOSInitializationSettings initializationSettingsMacOS =
  //     MacOSInitializationSettings();
  // final InitializationSettings initializationSettings = InitializationSettings(
  //     android: initializationSettingsAndroid,
  //     iOS: initializationSettingsIOS,
  //     macOS: initializationSettingsMacOS);
  // await Utils.shared.flutterLocalNotificationsPlugin.initialize(
  //     initializationSettings,
  //     onSelectNotification: selectNotification);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MyApp());
}

Future selectNotification(
  String? payload,
) async {
  //  Navigator.pushNamed(context, '/second');
}

Future onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  print('onDidReceiveLocalNotification');
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FCM Demo',
      routes: {
        '/': (context) => Home(),
        '/second': (context) => Second(),
      },
    );
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  if (message.data.isNotEmpty) {
    Utils.shared.channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    Utils.shared.flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    await Utils.shared.flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(Utils.shared.channel);
    final id = int.parse(message.data["count"] as String);
    Utils.shared.flutterLocalNotificationsPlugin.show(
        id,
        message.data["title"],
        message.data["body"],
        NotificationDetails(
          android: AndroidNotificationDetails(
            Utils.shared.channel.id,
            Utils.shared.channel.name,
            Utils.shared.channel.description,
            icon: 'launch_background',
          ),
        ));
  }
}
