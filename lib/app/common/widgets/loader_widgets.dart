import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

Widget loadingDialog({
  String? message,
}) {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      decoration: BoxDecoration(
        color: appColorWhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: defaultBoxShadow(),
      ),
      width: Get.width,
      padding: const EdgeInsets.symmetric(
        vertical: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          const CircularProgressIndicator(
            color: appColorSecondary,
          ),
          const SizedBox(height: 16),
          Text(
            message ?? "Espere Por favor...",
            style: primaryTextStyle(
              color: appColorPrimary,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget dialogBdp({
  Color? color,
  Color? iconColor,
  Color? iconBackground,
  IconData? icon,
  String? title,
  String? detail,
  Color? btnBackgroundColor,
  String? btnText,
  Color? btnColor,
  Function? action,
  bool? enableIcon,
  Widget? content,
  bool? disableClose,
}) {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
  return Dialog(
    backgroundColor: Colors.transparent,
    child: Container(
      padding: EdgeInsets.only(
        bottom: btnText is String ? 0 : 20,
      ),
      decoration: BoxDecoration(
        color: color ?? appColorWhite,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: defaultBoxShadow(),
      ),
      width: Get.width,
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
          Visibility(
            visible: disableClose != true,
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 15,
                ),
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.close,
                  color: appColorSecondary,
                ),
              ),
            ),
          ),
          SizedBox(
            height: disableClose == true ? 15 : 0,
          ),
          Visibility(
            visible: enableIcon ?? true,
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: EdgeInsets.only(
                bottom: (title != null || detail != null || btnText != null)
                    ? 15
                    : 0,
              ),
              decoration: BoxDecoration(
                color: iconBackground ?? appBackground,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon ?? Icons.security_update_outlined,
                color: iconColor ?? appColorSecondary,
                size: 30,
              ),
            ),
          ),
          Visibility(
            visible: title != null,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: titleBdp(
                title ?? "",
              ),
            ),
          ),
          Visibility(
            visible: detail is String,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 15,
              ),
              child: titleBdp(
                "$detail",
                size: 14,
                color: appTextNormal,
                weight: FontWeight.normal,
              ),
            ),
          ),
          Visibility(
            visible: btnText != null,
            child: Container(
              width: Get.width,
              height: 50,
              margin: EdgeInsets.only(top: detail is String ? 0 : 15),
              decoration: BoxDecoration(
                color: btnBackgroundColor ?? appColorSecondary,
                shape: BoxShape.rectangle,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              alignment: Alignment.center,
              child: titleBdp(
                "$btnText",
                color: btnColor ?? appColorWhite,
                size: 17,
              ),
            ).onTap(
              () {
                if (action != null) {
                  action();
                } else {
                  Get.back();
                }
              },
            ),
          ),
          Visibility(
            visible: content is Widget,
            child: content ?? const SizedBox(),
          ),
        ],
      ),
    ),
  );
}

Widget imageDialog(
  String image,
) {
  if (Get.isDialogOpen == true) {
    Get.back();
  }
  return Dialog(
    elevation: 0.0,
    child: Stack(
      children: [
        InteractiveViewer(
          child: CachedNetworkImage(
            imageUrl: image,
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: iconButton(
            Icons.close,
            color: appErrorColor,
            action: () {
              Get.back();
            },
          ),
        )
      ],
    ),
  );
}
