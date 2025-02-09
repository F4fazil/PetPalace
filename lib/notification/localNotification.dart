import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class LocalNotification {

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  Future<void> requestIOSPermissions() async {
    if (Platform.isIOS) {
      final IOSFlutterLocalNotificationsPlugin iosPlugin =
      flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()!;
      await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }
  Future<void> showNotification(String channel_id,String channel_name,String  channel_description) async {
     AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
      channel_id,
      channel_name,
      channelDescription: channel_description,
      importance: Importance.high,
      priority: Priority.high,
    );

    const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await flutterLocalNotificationsPlugin.show(
      0, // ID of the notification
      channel_name, // Title
      channel_description, // Body
      notificationDetails,
    );
  }
}
