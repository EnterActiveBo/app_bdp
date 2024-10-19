import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nb_utils/nb_utils.dart';

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

Widget pointBdp({
  Color? color,
}) {
  return Container(
    padding: const EdgeInsets.all(
      2,
    ),
    decoration: BoxDecoration(
      color: color ?? appColorPrimary,
      shape: BoxShape.circle,
    ),
  );
}

Widget iconTextActionBdp({
  String? title,
  Color? colorTitle,
  IconData? icon,
  Color? iconColor,
  double? iconSize,
  double? titleSize,
  FontWeight? titleWeight,
  TextAlign? titleAlign,
  double? space,
  double? mt,
  double? mb,
  Function? action,
  Widget? iconWidget,
  Widget? contentWidget,
}) {
  return Visibility(
    visible: title is String || contentWidget is Widget,
    child: GestureDetector(
      onTap: () {
        if (action != null) {
          action();
        }
      },
      child: Container(
        margin: EdgeInsets.only(
          top: mt ?? 0,
          bottom: mb ?? 0,
        ),
        child: Row(
          crossAxisAlignment:
              ((title ?? "").length <= 45 && contentWidget == null)
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
          children: [
            iconWidget ??
                Icon(
                  icon ?? Icons.location_on_outlined,
                  color: iconColor ?? appColorPrimary,
                  size: iconSize,
                ),
            SizedBox(
              width: space ?? 10,
            ),
            contentWidget ??
                textBdp(
                  "$title",
                  align: titleAlign ?? TextAlign.left,
                  color: colorTitle ?? appTextNormal,
                  weight: titleWeight ?? FontWeight.normal,
                  size: titleSize,
                ).expand(),
          ],
        ),
      ),
    ),
  );
}
