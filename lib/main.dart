import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:petpalace/notification/localNotification.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:petpalace/theme/app_theme.dart';
import 'package:provider/provider.dart';
import 'Database/Fav.dart';
import 'authentication/auth.dart';
import 'firebase_options.dart';
import 'constant/constant.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    // Initialize Flutter local notifications in the background
    LocalNotification().showNotification(
      'new_message_channel',
      'New Message',
      'You have a new message from the sender.',
    );
  }

  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotification().showNotification(
      "channel_id",
      message.notification?.title ?? "Notification",
      message.notification?.body ?? "You have a new message",
    );
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  const DarwinInitializationSettings initializationSettingsIOS =
      DarwinInitializationSettings();

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  Stripe.publishableKey = publishkey;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FavoriteManager())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
