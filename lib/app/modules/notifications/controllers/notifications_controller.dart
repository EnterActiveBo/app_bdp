import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/models/notification_model.dart';
import 'package:appbdp/app/models/providers/notification_provider.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter_app_badge_control/flutter_app_badge_control.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationsController extends GetxController {
  GetStorage box = GetStorage('App');
  final NotificationProvider notificationProvider =
      Get.put<NotificationProvider>(
    NotificationProvider(),
  );
  final RxList<NotificationModel> notifications =
      (List<NotificationModel>.of([])).obs;

  @override
  void onInit() {
    super.onInit();
    initData();
    getNotifications();
  }

  initData() {
    notifications.value = notificationsStored(box);
    box.listenKey("notifications", (value) {
      notifications.value = List<NotificationModel>.from(
        value.map(
          (v) {
            return v is NotificationModel ? v : NotificationModel.fromJson(v);
          },
        ),
      );
    });
  }

  goToNotifications() {
    getNotifications();
    Get.toNamed(Routes.NOTIFICATIONS);
    cleanBadges();
  }

  cleanBadges() async {
    await FlutterAppBadgeControl.removeBadge();
  }

  getNotifications() async {
    if (box.hasData('token')) {
      List<NotificationModel>? notificationResponse =
          await notificationProvider.getNotifications();
      if (notificationResponse is List<NotificationModel>) {
        box.write('notifications', notificationResponse);
      }
    }
  }

  view(int index) async {
    NotificationModel notification = notifications[index];
    if (!notification.view) {
      await notificationProvider.view(notification.id);
      notifications[index].view = true;
      box.write('notifications', notifications);
    }
  }
}
