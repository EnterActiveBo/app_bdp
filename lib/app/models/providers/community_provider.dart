import 'package:appbdp/app/common/http_config.dart';
import 'package:appbdp/app/constants/api.const.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CommunityProvider extends GetConnect {
  GetStorage box = GetStorage('App');

  @override
  void onInit() {
    httpClient.baseUrl = urlV1;
    httpDefaultConfiguration(httpClient, box);
  }

  Future<CommunityListModel?> getCommunities({
    Map<String, dynamic>? query,
  }) async {
    final response = await get(
      'communities',
      query: query,
    );
    if (response.body != null && response.body['data'] is List) {
      return CommunityListModel.fromJson(response.body);
    }
    return null;
  }

  Future<CommunityModel?> getCommunity(String communityId) async {
    final response = await get(
      "communities/$communityId",
    );
    if (response.body != null && response.body['data'] is Map) {
      return CommunityModel.fromJson(response.body['data']);
    }
    return null;
  }

  Future<bool> storeCommunity(Map data) async {
    final response = await post('communities', data);
    return response.isOk;
  }

  Future<bool> updateCommunity(
    String communityId,
    Map data,
  ) async {
    final response = await put("communities/$communityId", data);
    return response.isOk;
  }

  Future<bool> voteCommunity(
    String communityId,
    Map data,
  ) async {
    final response = await post("communities/$communityId/view-and-vote", data);
    return response.isOk;
  }

  Future<bool> sourceDelete(
    String communityId,
    String sourceId,
  ) async {
    final response = await delete(
      "communities/$communityId/resources/$sourceId",
    );
    return response.isOk;
  }

  Future<List<TagCommunityModel>?> getTags() async {
    final response = await get('tags-community');
    if (response.body != null && response.body['data'] is List) {
      return List<TagCommunityModel>.from(
        response.body['data'].map(
          (item) {
            return TagCommunityModel.fromJson(item);
          },
        ).toList(),
      );
    }
    return null;
  }
}
