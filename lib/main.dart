import 'package:appbdp/app/common/bindings/main_binding.dart';
import 'package:appbdp/app/common/controllers/main_controller.dart';
import 'package:appbdp/app/constants/app.theme.dart';
import 'package:appbdp/app/constants/scroll.dart';
import 'package:appbdp/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MainBinding().dependencies();
  final MainController controller = Get.find();
  initializeDateFormatting('es_BO');
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Status bar color
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(fcmBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  initNotifications();
  await FlutterDownloader.initialize(
    debug: false,
    ignoreSsl: true,
  );
  runApp(
    GetMaterialApp(
      title: "GESTOR DIGITAL BDP",
      theme: AppThemeData.lightThemeData,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      scrollBehavior: AppScrollBehavior(),
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      locale: const Locale("es", "BO"),
      supportedLocales: const [
        Locale("es", "BO"),
      ],
      routingCallback: (routing) {
        controller.setCurrent(routing?.current);
      },
    ),
  );
}

@pragma('vm:entry-point')
Future<void> fcmBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

Future<void> initNotifications() async {
  await FlutterLocalNotificationsPlugin().initialize(
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
