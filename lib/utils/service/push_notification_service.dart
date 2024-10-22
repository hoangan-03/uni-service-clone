import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_base_v2/utils/config/app_navigation.dart';
import 'package:flutter_base_v2/utils/service/log_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class PushNotificationService extends GetxService {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<String?> get fcmToken {
    return _firebaseMessaging.getToken();
  }

  StreamSubscription? onMessageListener;
  StreamSubscription? onMessageOpenedAppListener;
  StreamSubscription? onTokenRefreshListener;

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() {
    return _notificationsPlugin.getNotificationAppLaunchDetails();
  }

  void listenNotification() async {
    if (Platform.isIOS) {
      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
    onTokenRefreshListener = _firebaseMessaging.onTokenRefresh.listen((token) {
      L.debug('onTokenRefresh $token');
    });
    _configLocalNotification();
    onMessageListener =
        FirebaseMessaging.onMessage.listen(_handleNotificationOnForeground);
    onMessageOpenedAppListener = FirebaseMessaging.onMessageOpenedApp
        .listen(_handleNotificationOnBackground);
  }

  void _configLocalNotification() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();

    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsDarwin);

    await _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
  }

  void onDidReceiveNotificationResponse(NotificationResponse response) async {
    L.debug('onDidReceiveNotificationResponse $response');
    N.toNotifications();
  }

  Future<void> showLocalNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'fcm_default_channel_id',
      'fcm_default_channel_name',
      channelDescription: 'fcm_default_channel_description',
    );
    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _notificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  void cancelNotification() {
    onMessageListener?.cancel();
    onMessageOpenedAppListener?.cancel();
    onTokenRefreshListener?.cancel();
  }

  void handleNotificationOnTerminal() {
    _firebaseMessaging.getInitialMessage().then((message) {});
    N.toNotifications();
  }

  void _handleNotificationOnBackground(RemoteMessage message) {
    L.debug('Got a message in the background!');
    L.debug('Message data: ${message.data}');
    N.toNotifications();
  }

  void _handleNotificationOnForeground(RemoteMessage message) {
    L.debug('Got a message whilst in the foreground!');
    L.debug('Message data: ${message.data}');
    if (message.notification != null) {
      showLocalNotification(
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: json.encode(message.data),
      );
    }
  }
}
