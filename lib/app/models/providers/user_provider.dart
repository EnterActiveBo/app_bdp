import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return UserModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<UserModel>.from(
          map['data'].map(
            (item) {
              return UserModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<UserModel?> getProfile() async {
    final response = await get('profile');
    return response.body;
  }

  Future<Response> logout() async => await delete('auth-user/logout');
  Future<Response> destroy() async => await delete('destroy');
}
