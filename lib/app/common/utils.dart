import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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

bool searchString(String value, String? search) {
  return removeDiacritics(value).isCaseInsensitiveContains(
    removeDiacritics("$search"),
  );
}

String addTextExtra(String value, {String? extra, String? separator}) {
  String result = value;
  if (extra is String) {
    result += " ${separator is String ? separator : "|"} $extra";
  }
  return result;
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(
    r"<[^>]*>",
    multiLine: true,
    caseSensitive: true,
  );
  return htmlText.replaceAll(exp, '');
}

Future<void> downloadFile(
  String url, {
  String? token,
}) async {
  await FlutterDownloader.enqueue(
    url: url,
    headers: token is String
        ? {
            'Authorization': "Bearer $token",
          }
        : {},
    savedDir: await _prepareSaveDir(),
    saveInPublicStorage: true,
  );
}

Future<String> _prepareSaveDir() async {
  final localPath = (await _getSavedDir())!;
  final savedDir = Directory(localPath);
  if (!savedDir.existsSync()) {
    await savedDir.create();
  }
  return localPath;
}

Future<String?> _getSavedDir() async {
  String? externalStorageDirPath;

  if (Platform.isAndroid) {
    try {
      final download = await getDownloadsDirectory();
      externalStorageDirPath = download?.path;
    } catch (err, st) {
      debugPrint('failed to get downloads path: $err, $st');
      final directory = await getExternalStorageDirectory();
      externalStorageDirPath = directory?.path;
    }
  }

  return externalStorageDirPath;
}

String getFileSize(
  num bytes, {
  int? decimals,
}) {
  if (bytes <= 0) return "0 B";
  const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  var i = (log(bytes) / log(1024)).floor();
  return "${(bytes / pow(1024, i)).toStringAsFixed(decimals ?? 2)} ${suffixes[i]}";
}

String priceFormat(
  double price, {
  String? name,
}) {
  return NumberFormat.currency(
    locale: Intl.getCurrentLocale(),
    name: name ?? '',
  ).format(price);
}

Future<void> shareImage(
  Uint8List image, {
  String? title,
  String? detail,
}) async {
  String text = title ?? "GESTOR DIGITAL BDP";
  text += detail ?? "";
  DateTime now = DateTime.now();
  await Share.shareXFiles(
    [
      XFile.fromData(
        image,
        mimeType: "image/png",
        name: "BDP_${now.day}_${now.month}_${now.year}",
      ),
    ],
    text: text,
    subject: "GESTOR DIGITAL BDP",
  );
}
