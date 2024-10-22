import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/pathology_model.dart';
import 'package:appbdp/app/models/providers/pathology_provider.dart';
import 'package:appbdp/app/modules/pathologies/pathology/controllers/pathology_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PathologiesController extends GetxController {
  GetStorage box = GetStorage('App');
  final PathologyController pathologyController =
      Get.put(PathologyController());
  final PathologyProvider pathologyProvider = Get.find();
  String tagsPathologyKey = 'tagsPathology';
  final RxList<TagPathologyModel> tagsPathology =
      (List<TagPathologyModel>.of([])).obs;
  String pathologiesKey = 'pathologies';
  final RxList<PathologyModel> pathologies = (List<PathologyModel>.of([])).obs;
  final Rx<String?> search = (null as String?).obs;
  final RxList<String> tags = (List<String>.of([])).obs;
  final loading = true.obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loading.value = false;
    search.value = null;
    cleanTags();
  }

  initData() {
    initTags();
    initPathologies();
  }

  initTags() {
    tagsPathology.value = tagsPathologyStored(box);
    getTags();
  }

  getTags() async {
    List<TagPathologyModel>? tagsResponse =
        await pathologyProvider.getTagsPathology();
    if (tagsResponse is List<TagPathologyModel>) {
      tagsPathology.value = tagsResponse;
      box.write(tagsPathologyKey, tagsResponse);
      tagsPathology.refresh();
    }
  }

  initPathologies() {
    pathologies.value = pathologiesStored(box);
    getPathologies();
  }

  getPathologies() async {
    List<PathologyModel>? pathologiesResponse =
        await pathologyProvider.getPathologies();
    loading.value = false;
    if (pathologiesResponse is List<PathologyModel>) {
      pathologies.value = pathologiesResponse;
      box.write(pathologiesKey, pathologiesResponse);
      pathologies.refresh();
    }
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
  }

  setTag(String value) {
    int index = tags.indexOf(value);
    if (index >= 0) {
      tags.removeAt(index);
    } else {
      tags.add(value);
    }
    tags.refresh();
  }

  cleanTags() {
    tags.clear();
    tags.refresh();
  }

  List<PathologyModel> filterPathologies() {
    return pathologies.where((pathology) {
      bool filter = true;
      if (search.value is String) {
        filter &= searchString(
          pathology.title,
          search.value,
        );
        filter &= searchString(
          pathology.problem,
          search.value,
        );
        filter &= searchString(
          pathology.information,
          search.value,
        );
        filter &= searchString(
          pathology.handling,
          search.value,
        );
      }
      if (tags.isNotEmpty) {
        filter &= pathology.tags.any((tag) => tags.contains(tag.id));
      }
      return filter;
    }).toList();
  }

  setPathology(PathologyModel value) {
    pathologyController.setPathology(value);
    Get.toNamed(Routes.PATHOLOGY);
  }
}
