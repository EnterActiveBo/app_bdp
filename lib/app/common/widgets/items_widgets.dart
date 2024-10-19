import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/course_model.dart';
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
              height: Get.width / 1.8,
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
                  height: supplier.detail is String ? 10 : 0,
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
          )
        ],
      ),
    ),
  );
}

List<Widget> officeExtra(OfficeModel office, String type) {
  List<Widget> extra = [];
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
              mt: phone.key == 0 ? 0 : 8,
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
              mt: email.key == 0 ? 0 : 8,
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
              mt: schedule.key == 0 ? 0 : 8,
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
