import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/widgets.dart';

Widget titleBdp(
  String title, {
  Color? color,
  double? size,
  FontWeight? weight,
  TextOverflow? overflow,
  int? max,
  TextAlign? align,
}) {
  return Text(
    title,
    maxLines: max,
    textAlign: align ?? TextAlign.center,
    style: TextStyle(
      fontFamily: "exo2",
      color: color ?? appColorPrimary,
      fontSize: size ?? 17,
      fontWeight: weight ?? FontWeight.bold,
      overflow: overflow,
      height: 1,
    ),
  );
}

Widget textBdp(
  String? title, {
  Color? color,
  double? size,
  FontWeight? weight,
  TextOverflow? overflow,
  int? max,
  TextAlign? align,
}) {
  return Visibility(
    visible: title is String,
    child: Text(
      title ?? "",
      maxLines: max,
      textAlign: align ?? TextAlign.center,
      style: TextStyle(
        color: color ?? appTextNormal,
        fontSize: size ?? 15,
        fontWeight: weight ?? FontWeight.normal,
        overflow: overflow,
        height: 1,
      ),
    ),
  );
}
