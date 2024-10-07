import 'package:appbdp/app/common/bindings/main_binding.dart';
import 'package:appbdp/app/common/controllers/main_controller.dart';
import 'package:appbdp/app/constants/app.theme.dart';
import 'package:appbdp/app/constants/scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  runApp(
    GetMaterialApp(
      title: "AppBDP",
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
