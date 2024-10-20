import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HeaderBdpView extends GetView<NotificationsController>
    implements PreferredSizeWidget {
  final bool? primary;
  final String? title;
  final String? url;
  final double? rounded;
  const HeaderBdpView({
    super.key,
    this.primary,
    this.title,
    this.url,
    this.rounded,
  });
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title != null
          ? titleBdp(
              "$title",
              color: primary == true ? appColorWhite : appColorPrimary,
              max: 1,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      backgroundColor: primary == true ? appColorPrimary : appColorWhite,
      centerTitle: true,
      leadingWidth: primary == true ? null : 130,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(rounded ?? 30),
        ),
      ),
      leading: primary == true
          ? IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_outlined,
              ),
              onPressed: () {
                Get.back();
              },
            )
          : Container(
              margin: const EdgeInsets.only(
                left: 10,
              ),
              padding: const EdgeInsets.all(0),
              child: Image.asset(
                "assets/images/header_logo.png",
                filterQuality: FilterQuality.high,
              ),
            ),
      iconTheme: IconThemeData(
        color: primary == true ? appColorWhite : appColorPrimary,
      ),
      actionsIconTheme: IconThemeData(
        color: primary == true ? appColorWhite : appColorPrimary,
      ),
      actions: [
        Visibility(
          visible: url is String,
          child: IconButton(
            icon: const Icon(
              Icons.download_outlined,
              color: appColorWhite,
            ),
            onPressed: () {
              downloadFile("$url");
            },
          ),
        ),
        GestureDetector(
          onTap: () {
            controller.goToNotifications();
          },
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 13,
                  horizontal: 10,
                ),
                child: Icon(
                  Icons.notifications_none_outlined,
                  color: primary == true ? appColorWhite : appColorPrimary,
                ),
              ),
              Positioned(
                top: 0,
                right: 4,
                child: Obx(
                  () => Visibility(
                    visible: controller.notifications
                        .where(
                          (n) => !n.view,
                        )
                        .isNotEmpty,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: appColorThird,
                      ),
                      child: Text(
                        "${controller.notifications.where(
                              (n) => !n.view,
                            ).length}",
                        style: const TextStyle(
                          color: appColorWhite,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
