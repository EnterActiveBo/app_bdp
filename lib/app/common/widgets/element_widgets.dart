import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/banner_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

Widget iconWeightBdp(
  IconData icon, {
  double? size,
  FontWeight? weight,
  Color? color,
}) {
  return Text(
    String.fromCharCode(icon.codePoint),
    style: TextStyle(
      inherit: false,
      fontSize: size ?? 30,
      fontWeight: weight ?? FontWeight.w800,
      fontFamily: icon.fontFamily,
      color: color ?? appColorPrimary,
    ),
  );
}

Widget bannerSliderBdp(
  List<BannerModel> items,
) {
  var width = Get.width;
  final Size cardSize = Size(width, width / 1.8);
  return BannerView(
    viewportFraction: 0.9,
    height: cardSize.height,
    enlargeCenterPage: true,
    scrollDirection: Axis.horizontal,
    items: items.map((slider) {
      return SizedBox(
        width: cardSize.width,
        height: cardSize.height,
        child: Stack(
          children: <Widget>[
            Container(
              decoration: boxDecorationRoundedWithShadow(
                20,
                shadowColor: appColorTransparent,
              ),
              clipBehavior: Clip.antiAlias,
              child: CachedNetworkImage(
                imageUrl: slider.image.url,
                fit: BoxFit.fill,
                width: cardSize.width,
                height: cardSize.height,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Visibility(
                          visible: slider.button,
                          child: buttonBdp(
                            "${slider.buttonTitle}",
                            () {
                              if (slider.buttonUrl != null) {
                                openUrl("${slider.buttonUrl}");
                              }
                            },
                            textSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    }).toList(),
  );
}

Widget profileItem(
  IconData iconData, {
  String? title,
  double? pb,
  double? mb,
  bool? enableBorder,
  Color? color,
}) {
  return Visibility(
    visible: title is String,
    child: Container(
      padding: EdgeInsets.only(
        bottom: pb ?? 12,
      ),
      margin: EdgeInsets.only(
        bottom: mb ?? 12,
      ),
      decoration: (enableBorder ?? true == true)
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: .5,
                  color: appDivider,
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: appColorSecondary,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: appColorWhite,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          textBdp(
            title ?? "N/T",
            weight: FontWeight.normal,
            align: TextAlign.left,
            size: 15,
            color: color,
          ).expand(),
        ],
      ),
    ),
  );
}

Widget dividerBdp({
  double? width,
  double? height,
  double? margin,
  Color? color,
}) {
  return Container(
    width: width ?? Get.width,
    height: height ?? 1,
    margin: EdgeInsets.symmetric(
      vertical: margin ?? 10,
    ),
    color: color ?? appDivider,
  );
}

Widget iconRounded(
  IconData icon, {
  Color? color,
  Color? iconColor,
  double? ml,
  double? mr,
}) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: color ?? appColorThird,
      shape: BoxShape.circle,
    ),
    margin: EdgeInsets.only(
      left: ml ?? 0,
      right: mr ?? 0,
    ),
    child: Icon(
      icon,
      color: iconColor ?? appColorWhite,
    ),
  );
}

Widget iconButton(
  IconData icon, {
  Function? action,
  Color? color,
  Color? iconColor,
  double? ml,
  double? mr,
}) {
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: iconRounded(
      icon,
      color: color,
      iconColor: iconColor,
      ml: ml,
      mr: mr,
    ),
  );
}

Widget searchFilter(
  Key key, {
  TextEditingController? search,
  FocusNode? searchFocusNode,
  bool? isFilter,
  Function(String value)? searchAction,
  Function? action,
  Widget? filterWidget,
}) {
  return Form(
    key: key,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        textFieldBdp(
          hintText: "Buscar",
          textEditingController: search,
          textType: TextFieldType.OTHER,
          focusNode: searchFocusNode,
          margin: const EdgeInsets.symmetric(
            vertical: 5,
          ),
          suffixIcon: GestureDetector(
            onTap: () {
              if (action != null) {
                action();
              }
              FocusManager.instance.primaryFocus?.unfocus();
            },
            child: Icon(
              (isFilter == true) ? Icons.close : Icons.search_outlined,
              color: appColorThird,
            ),
          ),
          fillColor: appColorWhite,
          borderColor: appColorPrimary,
          borderRadius: 30,
          vertical: 0,
          horizontal: 20,
          onChanged: (search) {
            if (searchAction != null) {
              searchAction(search);
            }
          },
        ).expand(),
        filterWidget ?? const SizedBox(),
      ],
    ),
  );
}

Widget imageOrIcon({
  String? imageUrl,
  IconData? icon,
  double? iconSize,
  Color? iconColor,
  Color? backgroundColor,
  double? w,
  double? h,
}) {
  if (imageUrl is String) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: w ?? 60,
      height: h,
      fit: BoxFit.cover,
    );
  }
  return Container(
    width: w ?? 60,
    height: h ?? 75,
    decoration: BoxDecoration(
      color: backgroundColor ?? appColorThird,
    ),
    child: Icon(
      icon ?? Icons.school_outlined,
      color: iconColor ?? appColorWhite,
      size: iconSize ?? 50,
    ),
  );
}

Widget containerBdp({
  Widget? child,
  double? width,
  double? mt,
  double? mb,
  double? pv,
  double? ph,
  double? radius,
  Color? backgroundColor,
  BoxBorder? border,
  Function? action,
}) {
  return Visibility(
    visible: child is Widget,
    child: GestureDetector(
      onTap: () {
        if (action != null) {
          action();
        }
      },
      child: Container(
        width: width ?? Get.width,
        margin: EdgeInsets.only(
          top: mt ?? 0,
          bottom: mb ?? 0,
        ),
        padding: EdgeInsets.symmetric(
          vertical: pv ?? 20,
          horizontal: ph ?? 20,
        ),
        decoration: BoxDecoration(
          color: backgroundColor ?? appBackgroundOpacity,
          borderRadius: BorderRadius.circular(
            radius ?? 10,
          ),
          border: border,
        ),
        child: child,
      ),
    ),
  );
}
