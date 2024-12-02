import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/notification_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotificationProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}notifications";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map is Map &&
          map['data'] is Map<String, dynamic> &&
          map['data']['id'] is String) {
        return NotificationModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<NotificationModel>.from(
          map['data'].map(
            (item) {
              return NotificationModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<NotificationModel>?> getNotifications() async {
    final response = await get('/');
    return response.body;
  }

  Future<Response> view(String notificationId) async =>
      await post("/$notificationId/view", {});
}
