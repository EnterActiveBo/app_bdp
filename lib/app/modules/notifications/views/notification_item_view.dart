import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/notification_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class NotificationItemView extends StatefulWidget {
  final NotificationModel notification;
  final void Function() openNotification;
  const NotificationItemView({
    super.key,
    required this.notification,
    required this.openNotification,
  });

  @override
  _NotifyState createState() => _NotifyState();
}

class _NotifyState extends State<NotificationItemView> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: appBackground,
      ),
      child: ExpansionTile(
        initiallyExpanded: false,
        childrenPadding: const EdgeInsets.only(
          top: 0,
          left: 5,
          right: 5,
          bottom: 10,
        ),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: widget.notification.view ? appColorSecondary : appColorThird,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.notifications_active_outlined,
            color: appColorWhite,
            size: 30,
          ),
        ),
        title: titleBdp(
          widget.notification.title,
          align: TextAlign.left,
          size: 17,
        ),
        subtitle: textBdp(
          "${dateBdp(widget.notification.startAt)} al ${dateBdp(widget.notification.endAt)}",
          color: appTextNormal,
          size: 14,
          overflow: TextOverflow.ellipsis,
          weight: FontWeight.normal,
          align: TextAlign.left,
          max: 3,
        ),
        trailing: isExpanded
            ? const Icon(
                Icons.keyboard_arrow_up,
                color: appColorSecondary,
                size: 30,
              )
            : const Icon(
                Icons.keyboard_arrow_down,
                color: appColorSecondary,
                size: 30,
              ),
        onExpansionChanged: (t) {
          setState(
            () {
              isExpanded = !isExpanded;
            },
          );
          widget.openNotification();
        },
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: widget.notification.detail is String,
                  child: textBdp(
                    "${widget.notification.detail}",
                    color: appTextNormal,
                    size: 14,
                    overflow: TextOverflow.ellipsis,
                    weight: FontWeight.normal,
                    align: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: widget.notification.detail is String ? 20 : 0,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    bottom: 20,
                  ),
                  decoration: boxDecorationRoundedWithShadow(
                    20,
                    shadowColor: appColorTransparent,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: CachedNetworkImage(
                    imageUrl: widget.notification.image.url,
                    width: Get.width,
                    height: Get.width / 1.8,
                    fit: BoxFit.cover,
                  ),
                ),
                Visibility(
                  visible: widget.notification.button,
                  child: buttonBdp(
                    "${widget.notification.buttonTitle}",
                    () {
                      openUrl("${widget.notification.buttonUrl}");
                    },
                  ),
                ),
              ],
            ).paddingAll(8),
          )
        ],
      ),
    );
  }
}
