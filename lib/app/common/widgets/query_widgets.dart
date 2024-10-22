import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

Widget queryBdpWidget(
  bool condition,
  Widget mainWidget, {
  String? message,
  double? size,
  Color? textColor,
  Color? progressColor,
  bool? loading,
  FontWeight? textWeight,
  String? textFamily,
}) {
  if (condition) {
    return mainWidget;
  }
  if (loading == true) {
    return loadingBdp(
      message: message,
      size: size,
      textColor: textColor,
      progressColor: progressColor,
    );
  }
  return Center(
    child: titleBdp(
      message ?? "No existe información para mostrar.",
      size: size ?? 16,
      color: textColor,
      weight: textWeight,
      family: textFamily,
    ),
  );
}

Widget loadingBdp({
  String? message,
  Color? textColor,
  Color? progressColor,
  double? size,
}) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          color: progressColor ?? appColorPrimary,
        ),
        const SizedBox(height: 20),
        titleBdp(
          message ?? "Espere por favor ...",
          color: textColor ?? appColorSecondary,
          size: size ?? 16,
        ),
      ],
    ),
  );
}
