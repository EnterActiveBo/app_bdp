import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/modules/community/detailCommunity/controllers/detail_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormCommunityController extends GetxController {
  final CommunityProvider communityProvider = Get.find();
  final Rx<CommunityModel?> target = (null as CommunityModel?).obs;
  final Rx<CommunityModel?> reply = (null as CommunityModel?).obs;
  final Rx<CommunityModel?> community = (null as CommunityModel?).obs;
  final title = TextEditingController();
  final detail = TextEditingController();

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
    cleanForm();
  }

  setCommunity({
    CommunityModel? targetValue,
    CommunityModel? valueReply,
    CommunityModel? value,
  }) {
    cleanForm();
    target.value = targetValue;
    target.refresh();
    reply.value = valueReply;
    reply.refresh();
    community.value = value;
    community.refresh();
    if (community.value is CommunityModel) {
      title.text = community.value!.title;
      detail.text = community.value!.detail;
    }
  }

  saveCommunity(Map data) async {
    Get.dialog(
      dialogBdp(
        icon: Icons.save_outlined,
        title: '¿Publicar pregunta para comunidad?',
        btnText: 'Sí, publicar',
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          bool success = community.value is CommunityModel
              ? await communityProvider.updateCommunity(
                  community.value!.id,
                  data,
                )
              : await communityProvider.storeCommunity(data);
          Get.dialog(
            dialogBdp(
              disableClose: success,
              icon: success ? Icons.check_outlined : Icons.error_outlined,
              title: success
                  ? "Pregunta publicado Exitosamente"
                  : "Error al publicar la pregunta",
              btnText: success ? "Aceptar" : null,
              action: () {
                if (success) {
                  if (Get.isDialogOpen == true) {
                    Get.back();
                  }
                  if (Get.previousRoute == Routes.COMMUNITY) {
                    Get.offNamed(Routes.COMMUNITY);
                  }
                  if (target.value is CommunityModel) {
                    final DetailCommunityController detailCommunityController =
                        Get.find();
                    detailCommunityController.setCommunity(target.value!);
                    Get.offNamed(Routes.DETAIL_COMMUNITY);
                  }
                }
              },
            ),
          );
        },
      ),
    );
  }

  cleanForm() {
    title.text = "";
    detail.text = "";
    reply.value = null;
    reply.refresh();
    community.value = null;
    community.refresh();
    target.value = null;
    target.refresh();
  }
}
