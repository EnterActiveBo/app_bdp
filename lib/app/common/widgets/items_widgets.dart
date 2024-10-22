import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/models/supplier_model.dart';
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
                  ),
                ),
                SizedBox(
                  height: office.department is TargetModel ? 5 : 0,
                ),
                titleBdp(
                  office.title,
                ),
              ],
            ).expand(),
            Visibility(
              visible: office.mapUrl is String,
              child: iconButton(
                Icons.location_on_outlined,
                ml: 5,
                action: () {
                  openUrl("$office.mapUrl");
                },
              ),
            ),
            Visibility(
              visible: office.webUrl is String,
              child: iconButton(
                Icons.open_in_browser_outlined,
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
                  titleBdp(
                    title ?? "",
                    color: titleColor ?? appColorThird,
                    size: 18,
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
  String superTitle = "${courseBdp is CourseBdpModel ? "AULA " : ""}BDP";
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
                iconButton(Icons.edit_outlined,
                    color: appColorYellow, ml: 10, pd: 5, size: 15, action: () {
                  if (edit != null) {
                    edit();
                  }
                }),
                iconButton(Icons.delete_outline,
                    color: appErrorColor, ml: 10, pd: 5, size: 15, action: () {
                  if (delete != null) {
                    delete();
                  }
                }),
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
