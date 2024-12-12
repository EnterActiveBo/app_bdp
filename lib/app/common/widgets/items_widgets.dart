import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/supplier_model.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

Widget supplierItem(
  SupplierModel supplier, {
  double? mt,
  double? mb,
  Function? action,
}) {
  OfficeModel central = supplier.offices.firstWhere(
    (office) => office.head,
    orElse: () => supplier.offices.first,
  );
  List<Widget> phones = officeExtra(central, 'phones');
  List<Widget> emails = officeExtra(central, 'emails');
  List<Widget> schedules = officeExtra(central, 'schedules');
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      decoration: boxDecorationRoundedWithShadow(
        20,
        backgroundColor: appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: supplier.image is FileModel,
            child: CachedNetworkImage(
              imageUrl: "${supplier.image?.url}",
              width: Get.width,
              height: Get.width / 2.5,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
              horizontal: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: supplier.offices.isNotEmpty,
                  child: titleBdp(
                    supplier.offices
                        .map(
                          (office) => office.department?.name,
                        )
                        .join(" | "),
                    color: appColorThird,
                    size: 14,
                  ),
                ),
                SizedBox(
                  height: supplier.offices.isNotEmpty ? 5 : 0,
                ),
                titleBdp(
                  supplier.title,
                ),
                SizedBox(
                  height: supplier.detail is String ? 5 : 0,
                ),
                textBdp(
                  supplier.detail,
                  align: TextAlign.left,
                ),
                dividerBdp(),
                iconTextActionBdp(
                  title: central.address,
                ),
                SizedBox(
                  height: phones.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: phones.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.phone_android_outlined,
                    contentWidget: Column(
                      children: phones,
                    ).expand(),
                  ),
                ),
                SizedBox(
                  height: emails.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: emails.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.alternate_email_outlined,
                    contentWidget: Column(
                      children: emails,
                    ).expand(),
                  ),
                ),
                SizedBox(
                  height: schedules.isNotEmpty ? 5 : 0,
                ),
                Visibility(
                  visible: schedules.isNotEmpty,
                  child: iconTextActionBdp(
                    icon: Icons.calendar_month_outlined,
                    contentWidget: Column(
                      children: schedules,
                    ).expand(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

List<Widget> officeExtra(OfficeModel office, String type) {
  List<Widget> extra = [];
  double mt = 5;
  switch (type) {
    case 'phones':
      extra.addAll(
        office.phones.asMap().entries.map(
          (phone) {
            return iconTextActionBdp(
              iconWidget: pointBdp(),
              title: addTextExtra(
                phone.value.phone,
                extra: phone.value.detail,
              ),
              mt: phone.key == 0 ? 0 : mt,
              action: () {
                openUrl("tel://${phone.value.phone}");
              },
            );
          },
        ),
      );
      break;
    case 'emails':
      extra.addAll(
        office.emails.asMap().entries.map(
          (email) {
            return iconTextActionBdp(
              iconWidget: pointBdp(),
              title: addTextExtra(
                email.value.email,
                extra: email.value.detail,
              ),
              mt: email.key == 0 ? 0 : mt,
              action: () {
                openUrl("mailto://${email.value.email}");
              },
            );
          },
        ),
      );
      break;
    case 'schedules':
      extra.addAll(
        office.schedules.asMap().entries.map(
          (schedule) {
            return iconTextActionBdp(
              iconWidget: pointBdp(),
              title: addTextExtra(
                schedule.value.schedule,
                extra: schedule.value.detail,
              ),
              mt: schedule.key == 0 ? 0 : mt,
            );
          },
        ),
      );
      break;
    default:
  }
  return extra;
}

Widget officeItem(
  OfficeModel office, {
  double? mt,
  double? mb,
}) {
  List<Widget> phones = officeExtra(office, 'phones');
  List<Widget> emails = officeExtra(office, 'emails');
  List<Widget> schedules = officeExtra(office, 'schedules');
  return Container(
    width: Get.width,
    clipBehavior: Clip.antiAlias,
    padding: const EdgeInsets.symmetric(
      vertical: 25,
      horizontal: 20,
    ),
    margin: EdgeInsets.only(
      top: mt ?? 0,
      bottom: mb ?? 0,
    ),
    decoration: boxDecorationRoundedWithShadow(
      20,
      backgroundColor: appBackgroundOpacity,
      shadowColor: appColorTransparent,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: office.department is TargetModel,
                  child: titleBdp(
                    office.department?.name ?? "N/T",
                    color: appColorThird,
                    size: 14,
                    align: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: office.department is TargetModel ? 5 : 0,
                ),
                titleBdp(
                  office.title,
                  align: TextAlign.left,
                ),
              ],
            ).expand(),
            Visibility(
              visible: office.mapUrl is String,
              child: iconButton(
                Icons.location_on_outlined,
                ml: 5,
                action: () {
                  openUrl("${office.mapUrl}");
                },
              ),
            ),
            Visibility(
              visible: office.webUrl is String,
              child: iconButton(
                Icons.public_outlined,
                ml: 5,
                action: () {
                  openUrl("${office.webUrl}");
                },
              ),
            ),
          ],
        ),
        dividerBdp(
          margin: 15,
        ),
        iconTextActionBdp(
          title: office.address,
        ),
        SizedBox(
          height: phones.isNotEmpty ? 10 : 0,
        ),
        Visibility(
          visible: phones.isNotEmpty,
          child: iconTextActionBdp(
            icon: Icons.phone_android_outlined,
            contentWidget: Column(
              children: phones,
            ).expand(),
          ),
        ),
        SizedBox(
          height: emails.isNotEmpty ? 10 : 0,
        ),
        Visibility(
          visible: emails.isNotEmpty,
          child: iconTextActionBdp(
            icon: Icons.alternate_email_outlined,
            contentWidget: Column(
              children: emails,
            ).expand(),
          ),
        ),
        SizedBox(
          height: schedules.isNotEmpty ? 10 : 0,
        ),
        Visibility(
          visible: schedules.isNotEmpty,
          child: iconTextActionBdp(
            icon: Icons.calendar_month_outlined,
            contentWidget: Column(
              children: schedules,
            ).expand(),
          ),
        ),
      ],
    ),
  );
}

Widget imageDetailItem({
  String? title,
  String? detail,
  String? imageUrl,
  Color? backgroundColor,
  Color? titleColor,
  Color? detailColor,
  Function? action,
  double? pv,
  double? ph,
}) {
  return Visibility(
    visible: title is String,
    child: GestureDetector(
      onTap: () {
        if (action != null) {
          action();
        }
      },
      child: Container(
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: boxDecorationRoundedWithShadow(
          20,
          backgroundColor: backgroundColor ?? appColorPrimary,
          shadowColor: appColorTransparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: imageUrl is String,
              child: CachedNetworkImage(
                imageUrl: "$imageUrl",
                width: Get.width,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: pv ?? 20,
                horizontal: ph ?? 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBdp(
                    title ?? "",
                    color: titleColor ?? appColorThird,
                    size: 18,
                    align: TextAlign.left,
                  ),
                  SizedBox(
                    height: detail is String ? 10 : 0,
                  ),
                  textBdp(
                    detail,
                    color: detailColor ?? appColorWhite,
                    align: TextAlign.left,
                    size: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget courseItem({
  CourseModel? course,
  CourseBdpModel? courseBdp,
  Color? backgroundColor,
  Color? titleColor,
  Color? superTitleColor,
  double? mt,
  double? mb,
  double? imageW,
  double? imageH,
  int? radius,
  Function? action,
}) {
  String superTitle = "${courseBdp is CourseBdpModel ? "CURSO" : "EVENTO"} BDP";
  String title = course?.title ?? courseBdp?.title ?? "N/T";
  String dates = "";
  if (course is CourseModel) {
    dates = "${dateBdp(course.startAt)} - ${dateBdp(course.endAt)}";
  } else {
    dates = "${dateBdp(courseBdp?.startAt)} - ${dateBdp(courseBdp?.endAt)}";
  }
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      decoration: boxDecorationRoundedWithShadow(
        radius ?? 20,
        backgroundColor: backgroundColor ?? appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 0,
              child: imageOrIcon(
                imageUrl: course?.image?.url,
                svgIcon: course?.image?.url is! String,
                svgAsset: "assets/images/icons/cursos_bottom.svg",
                iconColor: appColorWhite,
                iconSize: 20,
                w: imageW ?? 80,
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleBdp(
                      superTitle,
                      color: superTitleColor ?? appColorThird,
                      size: 14,
                      align: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    titleBdp(
                      title,
                      size: 17,
                      color: titleColor ?? appColorPrimary,
                      max: 2,
                      overflow: TextOverflow.ellipsis,
                      align: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    iconTextActionBdp(
                      icon: Icons.calendar_month_outlined,
                      title: dates,
                      space: 5,
                    ),
                    const SizedBox(
                      height: 0,
                    ),
                    iconTextActionBdp(
                      icon: Icons.schedule_outlined,
                      title: course?.schedule,
                      space: 5,
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: appColorThird,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget courseModuleItem(
  ModuleBdpModel module, {
  Color? backgroundColor,
  Color? titleColor,
  Color? superTitleColor,
  double? mt,
  double? mb,
  double? imageW,
  double? imageH,
  int? radius,
  Function? action,
}) {
  IconData icon = Icons.file_present_outlined;
  switch (module.type) {
    case "2":
      icon = Icons.play_circle_fill_outlined;
      break;
    case "3":
      icon = Icons.image_outlined;
    case "4":
      icon = Icons.music_note_outlined;
    default:
  }
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      decoration: boxDecorationRoundedWithShadow(
        radius ?? 20,
        backgroundColor: backgroundColor ?? appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 0,
              child: imageOrIcon(
                icon: icon,
                iconColor: appColorWhite,
                iconSize: 35,
                w: imageW ?? 60,
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: titleBdp(
                  module.title,
                  size: 15,
                  color: titleColor ?? appColorPrimary,
                  max: 2,
                  weight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis,
                  align: TextAlign.left,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: appColorThird,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget newItemQuote(
  ItemQuoteModel quote, {
  double? mt,
  Function? edit,
  Function? delete,
}) {
  return Container(
    width: Get.width,
    margin: EdgeInsets.only(
      top: mt ?? 0,
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                textBdp(
                  quote.item,
                  align: TextAlign.left,
                ),
                iconButton(
                  Icons.edit_outlined,
                  color: appColorYellow,
                  ml: 10,
                  pd: 5,
                  size: 15,
                  action: () {
                    if (edit != null) {
                      edit();
                    }
                  },
                ),
                iconButton(
                  Icons.delete_outline,
                  color: appErrorColor,
                  ml: 10,
                  pd: 5,
                  size: 15,
                  action: () {
                    if (delete != null) {
                      delete();
                    }
                  },
                ),
              ],
            ),
            textBdp(
              "Cantidad ${quote.quantity} unidades",
              color: appTextLight,
              size: 12,
            ),
            textBdp(
              "Bs ${priceFormat(quote.price)}",
              color: appColorPrimary,
              size: 12,
            ),
          ],
        ).expand(),
        textBdp(
          "Bs ${priceFormat(quote.total())}",
          align: TextAlign.right,
          color: appTextNormal,
          weight: FontWeight.bold,
        ),
      ],
    ),
  );
}

Widget resourceItem(
  ResourcePathologyModel resource, {
  CourseModel? course,
  Color? backgroundColor,
  Color? titleColor,
  Color? superTitleColor,
  double? mt,
  double? mb,
  double? imageW,
  double? imageH,
  int? radius,
  Function? action,
}) {
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      padding: const EdgeInsets.only(
        right: 10,
      ),
      decoration: boxDecorationRoundedWithShadow(
        radius ?? 10,
        backgroundColor: backgroundColor ?? appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 0,
              child: imageOrIcon(
                imageUrl: resource.preview?.url,
                icon: Icons.file_copy_outlined,
                iconSize: 30,
                w: 55,
                h: 60,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: titleBdp(
                  resource.title,
                  size: 15,
                  color: titleColor ?? appColorPrimary,
                  max: 2,
                  overflow: TextOverflow.ellipsis,
                  align: TextAlign.left,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: appColorThird,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget pathologyShare(
  PathologyModel pathology,
) {
  ResourcePathologyModel? image = pathology.getImageFeatured();
  List<ResourcePathologyModel> files = pathology.getResourcesByType("file");
  return Container(
    width: Get.width,
    padding: const EdgeInsets.symmetric(
      vertical: 20,
      horizontal: 15,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: image is ResourcePathologyModel,
          child: Container(
            decoration: boxDecorationRoundedWithShadow(
              20,
              shadowColor: appColorTransparent,
            ),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: image?.source.url ?? "",
              fit: BoxFit.fill,
              width: Get.width,
              height: Get.width / 1.8,
            ),
          ),
        ),
        SizedBox(
          height: image is ResourcePathologyModel ? 20 : 0,
        ),
        Visibility(
          visible: pathology.tags.isNotEmpty == true,
          child: titleBdp(
            pathology.getTagsString() ?? "",
            color: appColorThird,
            size: 14,
          ),
        ),
        titleBdp(
          pathology.title,
        ),
        dividerBdp(),
        titleBdp(
          "Problema",
          size: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        textBdp(
          pathology.problem,
          size: 14,
          align: TextAlign.left,
        ),
        dividerBdp(),
        titleBdp(
          "Información",
          size: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        textBdp(
          pathology.information,
          size: 14,
          align: TextAlign.left,
        ),
        dividerBdp(),
        titleBdp(
          "Manejo",
          size: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        textBdp(
          pathology.handling,
          size: 14,
          align: TextAlign.left,
        ),
        dividerBdp(),
        Visibility(
          visible: files.isNotEmpty,
          child: titleBdp(
            "Más Información",
            size: 15,
          ),
        ),
        SizedBox(
          height: files.isNotEmpty ? 10 : 0,
        ),
        Column(
          children: files.asMap().entries.map(
            (resource) {
              return resourceItem(
                resource.value,
                mt: resource.key == 0 ? 0 : 15,
              );
            },
          ).toList(),
        ),
      ],
    ),
  );
}

Widget communityItem(
  CommunityModel community, {
  Color? backgroundColor,
  double? mt,
  double? mb,
  Function? action,
  bool? enableEdit,
  Function? actionEdit,
  bool? enableImage = true,
  int? maxTitle,
  TextOverflow? titleOverflow,
  int? maxDetail,
  TextOverflow? detailOverflow,
  double? voteIconSize,
  double? voteIconMr,
  double? voteIconPd,
  double? voteTitleSize,
  bool? showNextArrow = true,
  bool? showResources = false,
  Function? actionResource,
  bool? showReply = false,
  Function? actionReply,
  Function? actionNext,
  Function(bool)? actionVote,
}) {
  FileModel? imageFeatured = community.getImageFeatured();
  Widget content = Stack(
    children: [
      Container(
        width: Get.width,
        clipBehavior: Clip.antiAlias,
        decoration: boxDecorationRoundedWithShadow(
          20,
          backgroundColor: backgroundColor ?? appBackgroundOpacity,
          shadowColor: appColorTransparent,
        ),
        margin: EdgeInsets.only(
          top: mt ?? 0,
          bottom: mb ?? 0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: enableImage == true && imageFeatured is FileModel,
              child: CachedNetworkImage(
                imageUrl: "${imageFeatured?.url}",
                width: Get.width,
                height: Get.width / 2.5,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        iconRounded(
                          Icons.person_outlined,
                          color: appColorSecondary,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textRichBdp(
                              "${community.user.getName()} | ",
                              community.user.getFeatured() ?? "",
                              detailColor: appColorSecondary,
                              detailWeight: FontWeight.bold,
                            ),
                            textBdp(
                              dateDifferenceHumans(community.updatedAt),
                            ),
                          ],
                        ).expand(),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  titleBdp(
                    community.title,
                    color: appColorPrimary,
                    align: TextAlign.left,
                    max: maxTitle,
                    textHeight: 1,
                    overflow: titleOverflow,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  textBdp(
                    community.detail,
                    textHeight: 1,
                    align: TextAlign.left,
                    max: maxDetail,
                    overflow: detailOverflow,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: textBdp(
                      "${community.meta.interactions} Respuestas",
                      size: 13,
                      textHeight: 1,
                      align: TextAlign.right,
                      max: 2,
                      color: appTextLight,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  dividerBdp(),
                  Row(
                    children: [
                      voteContainer(
                        community.meta.positive,
                        icon: Icons.thumb_up_alt_outlined,
                        title: "Positivo",
                        iconSize: voteIconSize,
                        iconMr: voteIconMr,
                        iconPd: voteIconPd,
                        titleSize: voteTitleSize,
                        action: () {
                          if (actionVote != null) {
                            actionVote(true);
                          }
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      voteContainer(community.meta.negative,
                          icon: Icons.thumb_down_alt_outlined,
                          title: "Negativo",
                          iconSize: voteIconSize,
                          iconMr: voteIconMr,
                          iconPd: voteIconPd,
                          titleSize: voteTitleSize, action: () {
                        if (actionVote != null) {
                          actionVote(false);
                        }
                      }),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Visibility(
                              visible: showResources == true,
                              child: iconButton(
                                Icons.attach_file_outlined,
                                mr: 5,
                                color: appColorTransparent,
                                iconColor: appColorThird,
                                action: actionResource,
                              ),
                            ),
                            Visibility(
                              visible: showReply == true,
                              child: iconButton(
                                Icons.message_outlined,
                                mr: showNextArrow == true ? 5 : 0,
                                color: appColorTransparent,
                                iconColor: appColorThird,
                                action: actionReply,
                              ),
                            ),
                            Visibility(
                              visible: showNextArrow == true,
                              child: iconButton(
                                Icons.arrow_forward_ios_outlined,
                                color: appColorTransparent,
                                iconColor: appColorThird,
                                action: actionNext,
                              ),
                            ),
                          ],
                        ),
                      ).expand(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      Visibility(
        visible: enableEdit == true,
        child: Positioned(
          top: (mt ?? 0) + 10,
          right: 10,
          child: iconButton(
            Icons.edit_outlined,
            color: appColorYellow,
            pd: 5,
            size: 15,
            action: actionEdit,
          ),
        ),
      ),
    ],
  );
  return action == null
      ? content
      : GestureDetector(
          onTap: () {
            action();
          },
          child: content,
        );
}

Widget fileItem(
  FileModel resource, {
  Color? backgroundColor,
  Color? titleColor,
  Color? superTitleColor,
  double? mt,
  double? mb,
  double? imageW,
  double? imageH,
  int? radius,
  IconData? icon,
  Color? iconColor,
  Function? action,
}) {
  return GestureDetector(
    onTap: () {
      if (action != null) {
        action();
      }
    },
    child: Container(
      width: Get.width,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.only(
        top: mt ?? 0,
        bottom: mb ?? 0,
      ),
      padding: const EdgeInsets.only(
        right: 10,
      ),
      decoration: boxDecorationRoundedWithShadow(
        radius ?? 10,
        backgroundColor: backgroundColor ?? appBackgroundOpacity,
        shadowColor: appColorTransparent,
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Flexible(
              flex: 0,
              child: imageOrIcon(
                icon: Icons.file_copy_outlined,
                iconSize: 30,
                w: 55,
                h: 60,
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: Get.width,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 15,
                ),
                child: titleBdp(
                  resource.originalName,
                  size: 15,
                  color: titleColor ?? appColorPrimary,
                  max: 2,
                  overflow: TextOverflow.ellipsis,
                  align: TextAlign.left,
                ),
              ),
            ),
            Icon(
              icon ?? Icons.arrow_forward_ios_outlined,
              color: iconColor ?? appColorThird,
            ),
          ],
        ),
      ),
    ),
  );
}

Widget locationItems(
  List<ProductionLocationModel> locations, {
  String? unit,
}) {
  return Column(
    children: locations.asMap().entries.map((location) {
      return containerBdp(
        mt: location.key == 0 ? 0 : 15,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            titleBdp(
              location.value.department,
              align: TextAlign.left,
            ),
            const SizedBox(
              height: 5,
            ),
            textRichBdp(
              "Municipio: ",
              location.value.municipality,
              titleSize: 15,
              detailSize: 15,
            ),
            const SizedBox(
              height: 5,
            ),
            textRichBdp(
              "Producto: ",
              location.value.detail,
              titleSize: 15,
              detailSize: 15,
            ),
            const SizedBox(
              height: 5,
            ),
            textRichBdp(
              "${unit ?? "ha"}: ",
              priceFormat(location.value.quantity),
              titleSize: 15,
              detailSize: 15,
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget supportItem(
  SupportModel support, {
  double? mt,
  Function? action,
}) {
  return Stack(
    children: [
      containerBdp(
        backgroundColor: support.statusColor(),
        mt: mt,
        pv: 15,
        action: action,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBdp(
                    support.statusText(),
                    color: appColorThird,
                    size: 14,
                    align: TextAlign.left,
                  ),
                  titleBdp(
                    "Cliente: ${support.user.getName()}",
                    size: 12,
                    weight: FontWeight.normal,
                    color: support.status == 'close' ? appTextNormal : null,
                    align: TextAlign.left,
                  ),
                  titleBdp(
                    support.title,
                    textHeight: 0,
                    max: 2,
                    overflow: TextOverflow.ellipsis,
                    color: support.status == 'close' ? appTextNormal : null,
                    align: TextAlign.left,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  titleBdp(
                    "Última Actualización: ${dateBdp(
                      support.updatedAt,
                      format: "dd/MM/yyyy HH:mm",
                    )}",
                    size: 12,
                    weight: FontWeight.normal,
                    align: TextAlign.left,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            const Icon(
              Icons.arrow_forward_ios_outlined,
              color: appColorThird,
            ),
          ],
        ),
      ),
      Visibility(
        visible: support.messagesCount > 0,
        child: Positioned(
          top: (mt ?? 0) + 10,
          right: 10,
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: appColorThird,
            ),
            constraints: const BoxConstraints(
              minWidth: 20,
              maxWidth: 80,
            ),
            child: titleBdp(
              support.messagesCount.toString(),
              color: appColorWhite,
              size: 10,
              max: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    ],
  );
}
