import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/faq_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FaqProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}faq";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic> && map['data']['id'] is String) {
        return FaqModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<FaqModel>.from(
          map['data'].map(
            (item) {
              return FaqModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<FaqModel>?> getFaq() async {
    final response = await get('/');
    return response.body;
  }
}
