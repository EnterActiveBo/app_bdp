import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CourseBdpProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}courses-aula";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return CourseBdpModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<CourseBdpModel>.from(
          map['data'].map(
            (item) {
              return CourseBdpModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<CourseBdpModel>?> getCourses() async {
    final response = await get('/');
    return response.body;
  }

  Future<CourseBdpModel?> getCourse(num courseId) async {
    final response = await get("/$courseId");
    return response.body;
  }
}

class TopicBdpProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}courses-aula/";
    httpDefaultConfiguration(httpClient, box);
  }

  Future<List<TopicBdpModel>?> getTopics(num courseId) async {
    final response = await get("$courseId/topics");
    if (response.body != null && response.body['data'] is List) {
      return List<TopicBdpModel>.from(
        response.body['data'].map(
          (item) {
            return TopicBdpModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }

  Future<List<ModuleBdpModel>?> getModules(num topicId) async {
    final response = await get("$topicId/modules");
    if (response.body != null && response.body['data'] is List) {
      return List<ModuleBdpModel>.from(
        response.body['data'].map(
          (item) {
            return ModuleBdpModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }

  Future<ModuleBdpModel?> getModule(num moduleId) async {
    final response = await get("$moduleId/resource");
    if (response.body != null && response.body['data'] != null) {
      return ModuleBdpModel.fromJson(response.body['data']);
    }
    return null;
  }
}
