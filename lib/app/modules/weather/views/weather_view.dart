import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/weather_controller.dart';

class WeatherView extends GetView<WeatherController> {
  const WeatherView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WeatherView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WeatherView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
