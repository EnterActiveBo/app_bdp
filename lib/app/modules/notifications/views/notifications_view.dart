import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/models/notification_model.dart';
import 'package:appbdp/app/modules/notifications/views/notification_item_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Notificaciones",
      ),
      body: Obx(
        () {
          return queryBdpWidget(
            controller.notifications.isNotEmpty,
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.notifications.length,
                  itemBuilder: (context, index) {
                    NotificationModel notification =
                        controller.notifications[index];
                    return NotificationItemView(
                      notification: notification,
                      mt: index == 0 ? 0 : 15,
                      openNotification: () {
                        controller.view(index);
                      },
                    );
                  },
                ),
              ),
            ),
            message: "No existen notificaciones para mostrar",
          );
        },
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
