import 'package:appbdp/app/modules/notifications/controllers/notifications_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class MainController extends SuperController {
  final current = 2.obs;
  final List<String> routes = [
    Routes.NOTIFICATIONS,
    Routes.HOME,
    Routes.PROFILE,
  ];
  final NotificationsController notificationsController =
      Get.put<NotificationsController>(
    NotificationsController(),
    permanent: true,
  );

  @override
  void onDetached() {}

  @override
  void onInactive() {}

  @override
  void onPaused() {}

  @override
  void onResumed() {}

  @override
  void onHidden() {}

  void setCurrent(String? route) {
    int active = 0;
    bool change = true;
    if (route is String) {
      active = routes.indexWhere((r) => r == route);
      if (active == -1) {
        change = false;
        active = 2;
      }
    }
    if (change) {
      current.value = active;
    }
  }

  void goTo(int index) {
    if (index <= routes.length - 1) {
      Get.toNamed(routes[index]);
    }
  }
}
