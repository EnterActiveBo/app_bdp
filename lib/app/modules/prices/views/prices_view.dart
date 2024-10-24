import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prices_controller.dart';

class PricesView extends GetView<PricesController> {
  const PricesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PricesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PricesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
