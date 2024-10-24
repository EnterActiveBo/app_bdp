import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weather_controller.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Agroclimatico",
      ),
      body: const Center(
        child: Text(
          'WeatherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
