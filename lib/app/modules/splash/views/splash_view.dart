import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appColorPrimary,
      body: Center(
        child: Image.asset(
          'assets/images/splash.png',
          filterQuality: FilterQuality.high,
          width: 300,
        ),
      ),
    );
  }
}
