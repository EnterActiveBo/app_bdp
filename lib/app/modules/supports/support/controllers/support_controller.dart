import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/providers/file_provider.dart';
import 'package:appbdp/app/models/providers/support_provider.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final SupportProvider supportProvider = Get.find();
  final Rx<ScrollController> scrollController = ScrollController().obs;
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final Rx<SupportModel?> support = (null as SupportModel?).obs;
  final loading = true.obs;
  final FileProvider fileProvider = Get.find();
  final Rx<FilePickerResult?> fileUpload = (null as FilePickerResult?).obs;

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

  setSupport(
    SupportModel value, {
    UserModel? userValue,
  }) {
    loading.value = true;
    support.value = value;
    user.value = userValue;
    getSupport();
  }

  getSupport() async {
    SupportModel? supportResponse = await supportProvider.getSupport(
      support.value!.id,
    );
    loading.value = false;
    if (supportResponse is SupportModel) {
      support.value = supportResponse;
      support.refresh();
    }
    scrollController.value.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  closeSupport() async {
    if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.warning_amber_outlined,
        iconColor: appColorSecondary,
        title: '¿Cerrar Caso de Soporte?',
        btnText: 'Sí, cerrar',
        btnBackgroundColor: appColorSecondary,
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          await supportProvider.closeSupport(
            support.value!.id,
          );
          getSupport();
          Get.back();
        },
      ),
    );
  }

  storeMessage(Map data) async {
    bool success = await supportProvider.storeMessage(
      support.value!.id,
      data,
    );
    if (success) {
      getSupport();
      if (Get.isDialogOpen == true) {
        Get.back();
      }
    } else {
      Get.dialog(
        dialogBdp(
          icon: Icons.error_outlined,
          title: "Error al crear el mensaje",
          btnText: "Aceptar",
          action: () {
            Get.back();
          },
        ),
      );
    }
  }

  uploadFile() async {
    fileUpload.value = await FilePicker.platform.pickFiles(
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
        'mp4',
      ],
    );
    fileUpload.refresh();
    if (fileUpload.value is FilePickerResult) {
      Get.dialog(
        barrierDismissible: false,
        loadingDialog(),
      );
      FileModel? fileModel = await fileProvider.store(
        fileUpload.value!,
        folder: 'support',
      );
      if (fileModel is FileModel) {
        await storeMessage({
          "source_id": fileModel.id,
        });
      } else {
        Get.dialog(
          dialogBdp(
            icon: Icons.error_outlined,
            title:
                "Ocurrió un error al subir el archivo, por favor intente de nuevo.",
          ),
        );
        fileUpload.value = null;
        fileUpload.refresh();
      }
    }
  }

  showImage(FileModel image) {
    Get.dialog(
      imageDialog(
        image.url,
      ),
    );
  }

  showBottomSheet(
    MessageSupportModel message, {
    bool? showDelete,
  }) {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.bottomSheet(
      SizedBox(
        height: (message.message is String && showDelete == true) ? 120 : 80,
        child: containerBdp(
          child: Column(
            children: [
              Visibility(
                visible: message.message is String,
                child: iconTextActionBdp(
                  title: "Copiar Mensaje",
                  icon: Icons.content_copy_outlined,
                  iconColor: appColorThird,
                  action: () {
                    Clipboard.setData(
                      ClipboardData(
                        text: message.message ?? "",
                      ),
                    );
                    Get.back();
                    Get.snackbar(
                      "El mensaje ha sido copiado",
                      "El mensaje ha sido copiado al portapapeles",
                      icon: const Icon(
                        Icons.copy_outlined,
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
                  },
                ),
              ),
              SizedBox(
                height:
                    (message.message is String && showDelete == true) ? 15 : 0,
              ),
              Visibility(
                visible: showDelete == true,
                child: iconTextActionBdp(
                  title: "Eliminar",
                  icon: Icons.delete_outline,
                  iconColor: appErrorColor,
                  action: () {
                    showDeleteItem(message);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDeleteItem(
    MessageSupportModel message,
  ) {
    if (Get.isDialogOpen == true || Get.isBottomSheetOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.delete_outline,
        iconColor: appErrorColor,
        title: '¿Eliminar mensaje?',
        btnText: 'Sí, eliminar',
        btnBackgroundColor: appErrorColor,
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          await supportProvider.deleteMessage(
            support.value!.id,
            message.id,
          );
          getSupport();
          Get.back();
        },
      ),
    );
  }
}
