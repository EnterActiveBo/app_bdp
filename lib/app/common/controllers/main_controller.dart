import 'dart:convert';
import 'dart:io';

import 'package:appbdp/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class MainController extends SuperController {
  final current = 2.obs;
  final List<String> routes = [
    Routes.GOOD_PRACTICES,
    Routes.COMMUNITY,
    Routes.HOME,
    Routes.SUPPORTS,
    Routes.PROFILE,
  ];
  final NotificationsController notificationsController =
      Get.put<NotificationsController>(
    NotificationsController(),
    permanent: true,
  );
  //fcm
  final Rx<FirebaseMessaging?> messaging = (null as FirebaseMessaging?).obs;
  final Rx<NotificationSettings?> settings =
      (null as NotificationSettings?).obs;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel androidChannel =
      const AndroidNotificationChannel(
    'info_channel', // id
    'Information Notifications', // title
    description: 'Show all information for students', // description
    importance: Importance.high,
    playSound: true,
  );
  //end fcm

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {
    notificationsController.getNotifications();
  }

  @override
  void onHidden() {}

  void setCurrent(String? route) {
    int active = 0;
    bool change = true;
    if (route is String) {
      active = routes.indexWhere((r) => r == route);
      if (active == -1) {
        change = false;
        active = 2;
      }
    }
    if (change) {
      current.value = active;
    }
  }

  void goTo(int index) {
    if (index <= routes.length - 1) {
      Get.toNamed(routes[index]);
      notificationsController.getNotifications();
    }
  }

  startFCM() async {
    messaging.value = FirebaseMessaging.instance;
    settings.value = await messaging.value!.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    printInfo(
      info: "User granted permission: ${settings.value?.authorizationStatus}",
    );
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        printInfo(
          info: 'Got a message whilst in the foreground!',
        );
        printInfo(
          info: 'Message data: ${message.data}',
        );
        if (message.notification != null) {
          printInfo(
            info:
                'Message also contained a notification: ${message.notification}',
          );
          if (Platform.isAndroid) {
            showNotification(message.notification, data: message.data);
          }
          if (Platform.isIOS) {
            showNotificationIos(message.notification, data: message.data);
          }
          notificationsController.getNotifications();
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      printInfo(
        info: 'Message opened app!',
      );
      printInfo(
        info: 'Message data: ${message.data}',
      );
      if (message.notification != null) {
        printInfo(
          info:
              'Message also contained a notification: ${message.notification}',
        );
        Get.toNamed(
          message.data["type"] == "support"
              ? Routes.SUPPORTS
              : Routes.NOTIFICATIONS,
        );
        notificationsController.getNotifications();
      }
    });
  }

  Future<void> initNotifications() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('app_icon'),
        iOS: DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) {
        Get.toNamed(Routes.NOTIFICATIONS);
      },
    );
  }

  Future<void> showNotification(
    RemoteNotification? notification, {
    Map<String, dynamic>? data,
  }) async {
    if (Platform.isAndroid) {
      AndroidNotification? android = notification!.android;
      BigPictureStyleInformation? bdpStyle;
      if (android?.imageUrl is String) {
        final http.Response response = await http.get(
          Uri.parse("${android!.imageUrl}"),
        );
        bdpStyle = BigPictureStyleInformation(
          ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(
              response.bodyBytes,
            ),
          ),
          largeIcon: ByteArrayAndroidBitmap.fromBase64String(
            base64Encode(
              response.bodyBytes,
            ),
          ),
          contentTitle: notification.title,
          summaryText: notification.body,
        );
      }
      NotificationDetails notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
          androidChannel.id,
          androidChannel.name,
          channelDescription: androidChannel.description,
          priority: Priority.high,
          importance: Importance.max,
          icon: "app_icon",
          channelShowBadge: true,
          styleInformation: bdpStyle,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetail,
        payload: data?["type"],
      );
    }
  }

  Future<void> showNotificationIos(
    RemoteNotification? notification, {
    Map<String, dynamic>? data,
  }) async {
    AppleNotification? ios = notification!.apple;
    if (ios is AppleNotification) {
      List<DarwinNotificationAttachment> attachments = [];
      String? bigPicturePath;
      if (ios.imageUrl is String) {
        bigPicturePath = await _downloadAndSaveFile(
          ios.imageUrl ?? '',
          "bdp_notification.jpg",
        );
        attachments.add(
          DarwinNotificationAttachment(bigPicturePath),
        );
      }
      NotificationDetails notificationDetail = NotificationDetails(
        iOS: DarwinNotificationDetails(
          categoryIdentifier: 'plainCategory',
          attachments: attachments,
        ),
      );
      await flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        notificationDetail,
        payload: data?["type"],
      );
    }
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}
