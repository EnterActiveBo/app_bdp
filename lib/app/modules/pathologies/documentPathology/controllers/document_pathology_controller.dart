import 'package:appbdp/app/models/pathology_model.dart';
import 'package:get/get.dart';

class DocumentPathologyController extends GetxController {
  final Rx<ResourcePathologyModel?> resource =
      (null as ResourcePathologyModel?).obs;




  setResource(ResourcePathologyModel value) {
    resource.value = value;
  }

  String? pdfUrl() {
    return resource.value?.source.extension == "pdf"
        ? resource.value?.source.url
        : null;
  }
}
