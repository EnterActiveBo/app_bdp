import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/quiz_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuizProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}quiz/";
    httpDefaultConfiguration(httpClient, box);
  }

  Future<QuizModel?> getCurrent() async {
    final response = await get('current-quiz');
    if (response.body != null && response.body['data'] != null) {
      return QuizModel.fromJson(response.body['data']);
    }
    return null;
  }

  Future<bool> setQuiz(Map data) async {
    final response = await post('', data);
    return response.isOk;
  }

  Future<QuizResponseModel?> responseQuiz(String code) async {
    final response = await get(code);
    if (response.body != null && response.body['data'] != null) {
      return QuizResponseModel.fromJson(response.body['data']);
    }
    return null;
  }
}
