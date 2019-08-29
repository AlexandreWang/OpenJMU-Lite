import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:openjmu_lite/constants/constants.dart';


class NotificationUtils{
    static FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

    static initSettings() {
        AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher_trans');
        IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification,
        );
        InitializationSettings initializationSettings = InitializationSettings(
            initializationSettingsAndroid,
            initializationSettingsIOS,
        );
        NotificationUtils.plugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    }

    static Future<void> showNotification(String title, String body) async {
        final AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'openjmu_channel',
            'openjmu_course',
            'Channel for course notification.',
            importance: Importance.Max,
            priority: Priority.High,
            color: Constants.appThemeColor,
            style: AndroidNotificationStyle.BigText,
        );
        IOSNotificationDetails iOSPlatformChannelSpecifics = IOSNotificationDetails();
        NotificationDetails platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics,
            iOSPlatformChannelSpecifics,
        );
        await NotificationUtils.plugin.show(0, title, body, platformChannelSpecifics);
    }

    static Future<void> cancelAllNotifications() async {
        await NotificationUtils.plugin.cancelAll();
    }

    static Future<void> onDidReceiveLocalNotification(int id, String title, String body, String payload) async {}

    static Future<void> onSelectNotification(String payload) async {
        if (payload != null) {
            debugPrint('notification payload: ' + payload);
        }
    }

}