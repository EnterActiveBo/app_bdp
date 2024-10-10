import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/notification_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get_storage/get_storage.dart';

UserModel? userStored(GetStorage box) {
  String key = "user";
  if (box.hasData(key)) {
    var value = box.read(key);
    return value is UserModel ? value : UserModel.fromJson(value);
  }
  return null;
}

List<BannerModel> bannersStored(GetStorage box) {
  String key = "banners";
  if (box.hasData(key)) {
    return List<BannerModel>.from(
      box.read(key).map(
        (f) {
          return f is BannerModel ? f : BannerModel.fromJson(f);
        },
      ),
    );
  }
  return [];
}

List<NotificationModel> notificationsStored(GetStorage box) {
  String key = "notifications";
  if (box.hasData(key)) {
    return List<NotificationModel>.from(
      box.read(key).map(
        (f) {
          return f is NotificationModel ? f : NotificationModel.fromJson(f);
        },
      ),
    );
  }
  return [];
}
