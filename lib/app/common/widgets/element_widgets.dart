import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/banner_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/menu_model.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

Widget iconWeightBdp(
  IconData icon, {
  String? svg,
  double? size,
  FontWeight? weight,
  Color? color,
}) {
  if (svg is String) {
    return SvgPicture.asset(
      svg,
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(
        color ?? appColorPrimary,
        BlendMode.srcIn,
      ),
    );
  }
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

Widget menuHome(
  MenuModel menu, {
  double? mt,
  double? mb,
  double? pv,
  double? ph,
  double? radius,
}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(menu.page);
    },
    child: Container(
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      padding: EdgeInsets.symmetric(
        vertical: pv ?? 5,
        horizontal: ph ?? 5,
      ),
      decoration: BoxDecoration(
        color: menu.isPrimary ? appColorPrimary : appBackground,
        borderRadius: BorderRadius.circular(
          radius ?? 10,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            menu.getSvgAsset(),
            colorFilter: ColorFilter.mode(
              menu.isPrimary ? appColorWhite : appColorPrimary,
              BlendMode.srcIn,
            ),
            width: 40,
            height: 40,
          ),
          const SizedBox(height: 5),
          titleBdp(
            menu.title,
            size: 12,
            color: menu.isPrimary ? appColorWhite : null,
            textHeight: 1,
            align: TextAlign.center,
          ),
        ],
      ),
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
  double? pd,
  double? size,
}) {
  return Container(
    padding: EdgeInsets.all(pd ?? 10),
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
      size: size,
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
  double? pd,
  double? size,
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
      pd: pd,
      size: size,
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
  Widget content = Container(
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
    clipBehavior: Clip.antiAlias,
    child: child,
  );
  return Visibility(
    visible: child is Widget,
    child: () {
      if (action != null) {
        return GestureDetector(
          onTap: () {
            action();
          },
          child: content,
        );
      }
      return content;
    }(),
  );
}

Widget textRichBdp(
  String title,
  String detail, {
  Color? titleColor,
  Color? detailColor,
  double? titleSize,
  double? detailSize,
  FontWeight? titleWeight,
  FontWeight? detailWeight,
  TextOverflow? titleOverflow,
  TextOverflow? detailOverflow,
  TextAlign? align,
  bool? normalHeight,
}) {
  return RichText(
    textAlign: align ?? TextAlign.center,
    text: TextSpan(
      text: title,
      style: TextStyle(
        fontFamily: "exo2",
        color: titleColor ?? appColorPrimary,
        fontSize: titleSize ?? 14,
        fontWeight: titleWeight ?? FontWeight.bold,
        overflow: titleOverflow,
        height: normalHeight == true ? null : 1,
      ),
      children: <TextSpan>[
        TextSpan(
          text: detail,
          style: TextStyle(
            color: detailColor ?? appTextNormal,
            fontSize: detailSize ?? 12,
            fontWeight: detailWeight ?? FontWeight.normal,
            overflow: detailOverflow,
            height: normalHeight == true ? null : 1,
          ),
        ),
      ],
    ),
  );
}

Widget tagContainer({
  Widget? child,
  double? width,
  double? mt,
  double? mb,
  double? ml,
  double? pv,
  double? ph,
  double? radius,
  Color? backgroundColor,
  BoxBorder? border,
  Function? action,
}) {
  Widget content = Container(
    width: width,
    margin: EdgeInsets.only(
      left: ml ?? 0,
      top: mt ?? 0,
      bottom: mb ?? 0,
    ),
    padding: EdgeInsets.symmetric(
      vertical: pv ?? 10,
      horizontal: ph ?? 10,
    ),
    decoration: BoxDecoration(
      color: backgroundColor ?? appBackgroundOpacity,
      borderRadius: BorderRadius.circular(
        radius ?? 10,
      ),
      border: border,
    ),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
  return Visibility(
    visible: child is Widget,
    child: () {
      if (action != null) {
        return GestureDetector(
          onTap: () {
            action();
          },
          child: content,
        );
      }
      return content;
    }(),
  );
}

Widget pathologyItem(
  PathologyModel pathology, {
  Color? backgroundColor,
  Function? action,
}) {
  ResourcePathologyModel? imageFeatured = pathology.getImageFeatured();
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      clipBehavior: Clip.antiAlias,
      decoration: boxDecorationRoundedWithShadow(
        20,
        backgroundColor: backgroundColor ?? appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: imageFeatured is ResourcePathologyModel,
            child: CachedNetworkImage(
              imageUrl: "${imageFeatured?.source.url}",
              width: Get.width,
              height: 120,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 15,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: pathology.tags.isNotEmpty,
                  child: titleBdp(
                    "${pathology.getTagsString()}",
                    color: appColorThird,
                    size: 12,
                    max: imageFeatured is ResourcePathologyModel ? 1 : null,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                titleBdp(
                  pathology.title,
                  color: appColorPrimary,
                  align: TextAlign.left,
                  size: 13,
                  max: imageFeatured is ResourcePathologyModel ? 2 : null,
                  textHeight: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget pathologyBanner(
  List<ResourcePathologyModel> items,
) {
  var width = Get.width;
  final Size cardSize = Size(width, width / 1.8);
  return BannerView(
    viewportFraction: 0.9,
    height: cardSize.height,
    enlargeCenterPage: true,
    scrollDirection: Axis.horizontal,
    items: items.map(
      (slider) {
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
                  imageUrl: slider.source.url,
                  fit: BoxFit.fill,
                  width: cardSize.width,
                  height: cardSize.height,
                ),
              ),
            ],
          ),
        );
      },
    ).toList(),
  );
}

Widget voteContainer(
  bool active, {
  IconData? icon,
  double? iconSize,
  double? iconMr,
  double? iconPd,
  String? title,
  double? titleSize,
  Function? action,
}) {
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Row(
      children: [
        iconRounded(
          icon ?? Icons.thumb_down_alt_outlined,
          size: iconSize ?? 20,
          mr: iconMr ?? 5,
          pd: iconPd,
          color: active ? appColorThirdOpacity : appBackground,
          iconColor: active ? appColorThird : null,
        ),
        textBdp(
          title,
          size: titleSize ?? 12,
          color: active ? appColorThird : null,
          max: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ),
  );
}

Widget buttonCustom({
  Widget? child,
  double? width,
  double? mt,
  double? mb,
  double? pv,
  double? ph,
  int? radius,
  Color? backgroundColor,
  BoxBorder? border,
  Function? action,
}) {
  Widget content = Container(
    margin: EdgeInsets.only(
      top: mt ?? 0,
      bottom: mb ?? 0,
    ),
    padding: EdgeInsets.symmetric(
      vertical: pv ?? 20,
      horizontal: ph ?? 20,
    ),
    decoration: boxDecorationRoundedWithShadow(
      radius ?? 10,
      backgroundColor: backgroundColor ?? appBackgroundOpacity,
    ),
    clipBehavior: Clip.antiAlias,
    child: child,
  );
  return Visibility(
    visible: child is Widget,
    child: () {
      if (action != null) {
        return GestureDetector(
          onTap: () {
            action();
          },
          child: content,
        );
      }
      return content;
    }(),
  );
}

Widget communityBanner(
  List<FileModel> items,
) {
  var width = Get.width;
  final Size cardSize = Size(width, width / 1.8);
  return BannerView(
    viewportFraction: 0.9,
    height: cardSize.height,
    enlargeCenterPage: true,
    scrollDirection: Axis.horizontal,
    items: items.map(
      (slider) {
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
                  imageUrl: slider.url,
                  fit: BoxFit.fill,
                  width: cardSize.width,
                  height: cardSize.height,
                ),
              ),
            ],
          ),
        );
      },
    ).toList(),
  );
}
