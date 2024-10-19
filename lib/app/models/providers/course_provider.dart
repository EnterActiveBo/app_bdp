import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CourseProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}courses";
    httpDefaultConfiguration(httpClient, box);
    httpClient.defaultDecoder = (map) {
      if (map['data'] is Map<String, dynamic>) {
        return CourseModel.fromJson(map['data']);
      }
      if (map['data'] is List) {
        return List<CourseModel>.from(
          map['data'].map(
            (item) {
              return CourseModel.fromJson(item);
            },
          ).toList(),
        );
      }
    };
  }

  Future<List<CourseModel>?> getCourses() async {
    final response = await get('/');
    return response.body;
  }
}
