import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SupportProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = "${urlV1}supports/";
    httpDefaultConfiguration(httpClient, box);
  }

  Future<SupportListModel?> getSupports({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      '',
      query: query,
    );
    if (response.body != null && response.body['data'] != null) {
      return SupportListModel.fromJson(response.body);
    }
    return null;
  }

  Future<SupportModel?> getSupport(String supportId) async {
    final response = await get(supportId);
    if (response.body != null && response.body['data'] != null) {
      return SupportModel.fromJson(response.body['data']);
    }
    return null;
  }

  Future<bool> storeSupport(Map data) async {
    final response = await post('', data);
    return response.isOk;
  }

  Future<bool> closeSupport(
    String supportId,
  ) async {
    final response = await patch("$supportId/close", {});
    return response.isOk;
  }

  Future<bool> storeMessage(String supportId, Map data) async {
    final response = await post("$supportId/messages", data);
    return response.isOk;
  }

  Future<bool> deleteMessage(String supportId, String messageId) async {
    final response = await delete("$supportId/messages/$messageId");
    return response.isOk;
  }

  Future<bool> readMessages(
    String supportId,
    List<MessageSupportModel> messages,
  ) async {
    final response = await post(
      "$supportId/view-messages",
      {
        'viewed': messages.map((x) => x.id).toList(),
      },
    );
    return response.isOk;
  }
}
