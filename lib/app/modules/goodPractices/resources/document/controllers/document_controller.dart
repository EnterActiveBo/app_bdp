import 'package:appbdp/app/models/resource_model.dart';
import 'package:get/get.dart';

class DocumentController extends GetxController {
  final Rx<ResourceModel?> resource = (null as ResourceModel?).obs;

  setDocument(ResourceModel item) {
    resource.value = item;
  }

  String? pdfUrl() {
    return resource.value?.source?.extension == "pdf"
        ? resource.value?.source?.url
        : null;
  }
}
