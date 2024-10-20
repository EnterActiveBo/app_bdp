import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/providers/category_provider.dart';
import 'package:appbdp/app/models/resource_model.dart';
import 'package:appbdp/app/modules/goodPractices/resources/controllers/resources_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GoodPracticesController extends GetxController {
  GetStorage box = GetStorage('App');
  String categoriesKey = 'categories';
  ResourcesController resourcesController = Get.find();
  CategoryProvider categoryProvider = Get.find();
  final RxList<CategoryResourceModel> categories =
      (List<CategoryResourceModel>.of([])).obs;
  final Rx<String?> search = (null as String?).obs;
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
    loading.value = true;
    search.value = null;
  }

  initData() {
    categories.value = categoriesStored(box);
    getCategories();
  }

  getCategories() async {
    List<CategoryResourceModel>? categoriesResponse =
        await categoryProvider.getCategories();
    loading.value = false;
    if (categoriesResponse is List<CategoryResourceModel>) {
      categories.value = categoriesResponse;
      box.write(categoriesKey, categoriesResponse);
    }
  }

  setSearch(String? value) {
    search.value = value == "" ? null : value;
  }

  List<CategoryResourceModel> filterCategories() {
    return categories.where((category) {
      bool filter = true;
      if (search.value is String) {
        filter &= searchString(
          category.title,
          search.value,
        );
        filter |= searchString(
          category.category?.title ?? "BDP",
          search.value,
        );
      }
      return filter;
    }).toList();
  }

  setCategory(CategoryResourceModel value) {
    resourcesController.setCategory(value);
    Get.toNamed(Routes.RESOURCES);
  }
}
