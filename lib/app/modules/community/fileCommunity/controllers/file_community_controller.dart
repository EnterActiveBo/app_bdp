import 'package:appbdp/app/models/banner_model.dart';
import 'package:get/get.dart';

class FileCommunityController extends GetxController {
  final Rx<FileModel?> resource = (null as FileModel?).obs;

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

  setResource(FileModel value) {
    resource.value = value;
  }

  String? pdfUrl() {
    return resource.value?.extension == "pdf" ? resource.value?.url : null;
  }
}
