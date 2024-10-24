import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/prices_controller.dart';

class PricesView extends GetView<PricesController> {
  const PricesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Mapa de Complejidades",
      ),
      body: const Center(
        child: Text(
          'PricesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
