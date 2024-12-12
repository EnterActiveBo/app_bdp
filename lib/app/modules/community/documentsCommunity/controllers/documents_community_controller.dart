import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/modules/community/fileCommunity/controllers/file_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class DocumentsCommunityController extends GetxController {
  final CommunityProvider communityProvider = Get.find();
  final Rx<CommunityModel?> community = (null as CommunityModel?).obs;
  final FileCommunityController fileCommunityController = Get.find();
  final loading = true.obs;

  @override
  void onClose() {
    super.onClose();
    loading.value = true;
  }

  setCommunity(CommunityModel value) {
    community.value = value;
    getCommunity();
  }

  setDocument(FileModel value) {
    fileCommunityController.setResource(value);
    Get.toNamed(Routes.FILE_COMMUNITY);
  }

  getCommunity() async {
    if (community.value is CommunityModel) {
      loading.value = true;
      CommunityModel? communityResponse = await communityProvider.getCommunity(
        community.value!.id,
      );
      loading.value = false;
      if (communityResponse is CommunityModel) {
        community.value = communityResponse;
        community.refresh();
      }
    }
  }
}
