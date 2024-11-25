import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:appbdp/app/models/providers/community_provider.dart';
import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:appbdp/app/modules/community/detailCommunity/controllers/detail_community_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormCommunityController extends GetxController {
  final CommunityProvider communityProvider = Get.find();
  final FileProvider fileProvider = Get.find();
  final Rx<FilePickerResult?> resourceFile = (null as FilePickerResult?).obs;
  final Rx<CommunityModel?> target = (null as CommunityModel?).obs;
  final Rx<CommunityModel?> reply = (null as CommunityModel?).obs;
  final Rx<CommunityModel?> community = (null as CommunityModel?).obs;
  final title = TextEditingController();
  final detail = TextEditingController();
  final RxList<ResourceCommunityModel> sources =
      (List<ResourceCommunityModel>.of([])).obs;

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
      sources.value = community.value!.resources;
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
                  if (target.value is CommunityModel) {
                    final DetailCommunityController detailCommunityController =
                        Get.find();
                    detailCommunityController.setCommunity(target.value!);
                    Get.offNamed(Routes.DETAIL_COMMUNITY);
                  } else {
                    Get.offAllNamed(Routes.COMMUNITY);
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

  uploadFile() async {
    Get.dialog(
      barrierDismissible: false,
      loadingDialog(),
    );
    resourceFile.value = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'png',
        'jpg',
        'jpeg',
        'pdf',
        'doc',
        'docx',
        'xls',
        'xlsx',
        'ppt',
        'pptx',
      ],
    );
    resourceFile.refresh();
    if (resourceFile.value is FilePickerResult) {
      FileModel? fileResponse = await fileProvider.store(
        resourceFile.value!,
        folder: 'community',
      );
      if (fileResponse is FileModel) {
        sources.add(
          ResourceCommunityModel(
            source: fileResponse,
          ),
        );
        Get.dialog(
          dialogBdp(
            icon: Icons.check_outlined,
            title: "Recurso subido correctamente.",
          ),
        );
      } else {
        Get.dialog(
          dialogBdp(
            icon: Icons.error_outlined,
            title:
                "Ocurrió un error al subir la imagen, por favor intente de nuevo.",
          ),
        );
        resourceFile.value = null;
      }
    } else {
      Get.snackbar(
        "Por favor seleccione una imagen",
        "debe seleccionar una imagen para continuar.",
        icon: const Icon(
          Icons.error_outline,
          color: appColorWhite,
          size: 35,
        ),
        colorText: appColorWhite,
        backgroundColor: appColorSecondary,
        duration: const Duration(minutes: 1),
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        margin: const EdgeInsets.all(10),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  removeSource(int index) {
    Get.dialog(
      dialogBdp(
        icon: Icons.delete_outlined,
        title: '¿Eliminar recurso?',
        btnText: 'Sí, eliminar',
        action: () async {
          ResourceCommunityModel resource = sources.removeAt(index);
          sources.refresh();
          if (community.value is CommunityModel && resource.id is String) {
            await communityProvider.sourceDelete(
              community.value!.id,
              resource.id!,
            );
          }
          if (Get.isDialogOpen == true) {
            Get.back();
          }
        },
      ),
    );
  }
}
