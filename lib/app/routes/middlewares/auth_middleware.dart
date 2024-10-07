import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthMiddleware extends GetMiddleware {
  GetStorage box = GetStorage('App');

  @override
  RouteSettings? redirect(String? route) {
    return !box.hasData('token')
        ? const RouteSettings(name: Routes.LOGIN)
        : null;
  }
}
