import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:appbdp/app/modules/pathologies/documentPathology/controllers/document_pathology_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:screenshot/screenshot.dart';

class PathologyController extends GetxController {
  final DocumentPathologyController documentController = Get.find();
  final Rx<PathologyModel?> pathology = (null as PathologyModel?).obs;
  ScreenshotController screenshotController = ScreenshotController();

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
  }

  setPathology(PathologyModel value) {
    pathology.value = value;
  }

  sharePathology(BuildContext context) {
    if (pathology.value is PathologyModel) {
      Get.dialog(
        barrierDismissible: false,
        loadingDialog(),
      );
      screenshotController
          .captureFromLongWidget(
        InheritedTheme.captureAll(
          context,
          Material(
            color: appColorWhite,
            child: pathologyShare(
              pathology.value!,
            ),
          ),
        ),
        delay: const Duration(
          seconds: 1,
        ),
      )
          .then(
        (capturedImage) {
          if (Get.isDialogOpen == true) {
            Get.back();
          }
          shareImage(
            capturedImage,
            detail: pathology.value?.title,
          );
        },
      );
    }
  }

  setDocument(ResourcePathologyModel value) {
    documentController.setResource(value);
    Get.toNamed(Routes.DOCUMENT_PATHOLOGY);
  }
}
