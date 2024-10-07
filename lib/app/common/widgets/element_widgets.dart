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
