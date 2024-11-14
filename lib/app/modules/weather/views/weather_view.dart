import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
      body: Obx(
        () => SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              titleBdp(
                "Reporte de Clima",
              ),
              const SizedBox(
                height: 2,
              ),
              textBdp(
                controller.user.value?.profile?.getDepartmentLocality(),
                color: appColorThird,
                weight: FontWeight.bold,
                size: 12,
              ),
              queryBdpWidget(
                !controller.loadingWeather.value &&
                    controller.weather.value is WeatherModel,
                containerBdp(
                  ph: 0,
                  pv: 0,
                  mb: 15,
                  child: CachedNetworkImage(
                    imageUrl: controller.weather.value?.image.url ?? "",
                    width: Get.width,
                    fit: BoxFit.cover,
                  ),
                ),
                loading: controller.loadingWeather.value,
              ),
              Visibility(
                visible: controller.weather.value is WeatherModel,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: buttonBdp(
                    "Descargar",
                    () {
                      if (controller.weather.value?.image is FileModel) {
                        downloadFile(controller.weather.value!.image.url);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
