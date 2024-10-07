import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

errorBdp(Response response) {
  IconData icon = Icons.warning_amber_outlined;
  String title = "¡Atención!";
  String? detail;
  if (response.unauthorized) {
    Get.offAllNamed('/login');
    icon = Icons.error_outline;
    title = "Sesión Expirada";
    detail = "Su sesión a expirado, por favor inicie sesión nuevamente.";
  } else {
    if (response.status.connectionError) {
      icon = Icons.signal_wifi_connected_no_internet_4_outlined;
      title = "¡Error de Conexión!";
      detail = "Por favor, verifique el estado de su conexión a Internet.";
    } else {
      detail = (response.body['errors'] is List &&
              response.body['errors'].length > 0 &&
              response.body['errors'][0]['message'] != null)
          ? response.body['errors'][0]['message']
          : "Ocurrió un problema en el servidor, por favor inténtelo nuevamente más tarde.";
    }
  }
  Get.dialog(
    barrierDismissible: false,
    dialogBdp(
      icon: icon,
      title: title,
      detail: detail,
    ),
  );
}

Future<void> openUrl(String url) async {
  final Uri urlParse = Uri.parse(url);
  if (!await launchUrl(
    urlParse,
    mode: LaunchMode.externalApplication,
  )) {
    throw Exception('error on open $urlParse');
  }
}

String? dateBdp(DateTime? date, {String? format}) {
  if (date is DateTime) {
    return DateFormat(
      format ?? "dd/MM/yyyy",
      "es_BO",
    ).format(date);
  }
  return null;
}
