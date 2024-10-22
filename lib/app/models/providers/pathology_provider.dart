import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PathologyProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(httpClient, box);
  }

  Future<List<PathologyModel>?> getPathologies() async {
    final response = await get('pathologies');
    if (response.body['data'] is List) {
      return List<PathologyModel>.from(
        response.body['data'].map(
          (item) {
            return PathologyModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }

  Future<List<TagPathologyModel>?> getTagsPathology() async {
    final response = await get('pathologies/tags');
    if (response.body['data'] is List) {
      return List<TagPathologyModel>.from(
        response.body['data'].map(
          (item) {
            return TagPathologyModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }
}
