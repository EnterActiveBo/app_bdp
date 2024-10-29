import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/modules/community/documentsCommunity/controllers/documents_community_controller.dart';
import 'package:appbdp/app/modules/community/formCommunity/controllers/form_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DetailCommunityController extends GetxController {
  GetStorage box = GetStorage('App');
  final CommunityProvider communityProvider = Get.find();
  final DocumentsCommunityController documentsCommunityController = Get.find();
  final Rx<CommunityModel?> community = (null as CommunityModel?).obs;
  final Rx<CommunityModel?> prev = (null as CommunityModel?).obs;
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loading.value = true;
  }

  setCommunity(
    CommunityModel value, {
    CommunityModel? prevValue,
  }) async {
    community.value = value;
    getCommunity();
    user.value = userStored(box);
    prev.value = prevValue;
    prev.refresh();
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

  setCommunityForm({
    CommunityModel? targetValue,
    CommunityModel? value,
    CommunityModel? reply,
  }) {
    final FormCommunityController formCommunityController = Get.find();
    formCommunityController.setCommunity(
      targetValue: targetValue,
      value: value,
      valueReply: reply,
    );
    Get.toNamed(Routes.FORM_COMMUNITY);
  }

  setDocumentCommunity(CommunityModel value) {
    documentsCommunityController.setCommunity(value);
    Get.toNamed(Routes.DOCUMENTS_COMMUNITY);
  }

  setVote(
    bool value, {
    int? index,
  }) async {
    Get.dialog(
      barrierDismissible: false,
      loadingDialog(),
    );
    if (index is int &&
        community.value?.children.isNotEmpty == true &&
        community.value?.children[index] is CommunityModel) {
      community.value?.children[index].meta.positive = value;
      community.value?.children[index].meta.negative = !value;
      await communityProvider.voteCommunity(
        community.value?.children[index].id ?? "",
        {
          "vote": value,
        },
      );
    } else {
      community.value?.meta.positive = value;
      community.value?.meta.negative = !value;
    }
    community.refresh();

    if (Get.isDialogOpen == true) {
      Get.back();
    }
  }
}
