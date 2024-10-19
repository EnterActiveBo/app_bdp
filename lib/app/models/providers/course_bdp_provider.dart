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
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return TopicBdpModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<TopicBdpModel>.from(
          map['data'].map(
            (item) {
              return TopicBdpModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<TopicBdpModel>?> getTopics(num courseId) async {
    final response = await get("/$courseId/topics");
    return response.body;
  }
}
