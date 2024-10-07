import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BannerProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}banners";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is List) {
        return List<BannerModel>.from(
          map['data'].map(
            (item) {
              return BannerModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<BannerModel>?> getBanners() async {
    final response = await get('/');
    return response.body;
  }
}
