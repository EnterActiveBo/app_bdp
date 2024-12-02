import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';
import 'package:get_storage/get_storage.dart';

httpDefaultConfiguration(
  GetHttpClient httpClient,
  GetStorage box, {
  bool? enabledContentType,
  int? timeout,
}) {
  httpClient.timeout = Duration(
    seconds: timeout ?? 300,
  );
  httpClient.addRequestModifier((Request request) {
    request.headers['Accept'] = "application/json";
    if (enabledContentType ?? true) {
      request.headers['Content-Type'] = "application/json";
    }
    request.headers['XMLHttpRequest'] = "XMLHttpRequest";
    request.headers['Charset'] = "utf-8";
    if (box.hasData('token')) {
      request.headers['Authorization'] = "Bearer ${box.read('token')}";
    }
    return request;
  });
  httpClient.addResponseModifier((request, response) {
    if (response.unauthorized) {
      box.remove('token');
      box.erase();
      Get.offAllNamed(
        Routes.LOGIN,
        arguments: {
          "logout": true,
        },
      );
    }
    return response;
  });
}
