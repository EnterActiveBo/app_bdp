import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/models/providers/support_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/support_model.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/modules/supports/support/controllers/support_controller.dart';
import 'package:appbdp/app/modules/supports/views/new_support_view.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SupportsController extends GetxController {
  GetStorage box = GetStorage('App');
  final UserProvider userProvider = Get.find();
  final SupportController supportController = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final SupportProvider supportProvider = Get.find();
  RxList<SupportModel> supports = <SupportModel>[].obs;
  final Rx<MetaListModel?> meta = (null as MetaListModel?).obs;
  final loading = true.obs;
  final perPage = 10.obs;
  final currentPage = 1.obs;

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
  }

  initData() {
    initUser();
    initSupports();
  }

  initSupports() async {
    getSupports();
  }

  getSupports() async {
    Map<String, dynamic> query = getQuery();
    loading.value = currentPage.value == 1;
    SupportListModel? response = await supportProvider.getSupports(
      query: query,
    );
    loading.value = false;
    if (response is SupportListModel) {
      supports.value = response.data;
      meta.value = response.meta;
    }
  }

  Map<String, dynamic> getQuery() {
    Map<String, dynamic> query = {
      "page": currentPage.toString(),
      "limit": perPage.toString(),
    };
    query.removeWhere((key, value) => value == null);
    return query;
  }

  getNextPage() {
    if (meta.value is MetaListModel) {
      if (meta.value!.currentPage < meta.value!.lastPage) {
        currentPage.value = meta.value!.currentPage + 1;
        getSupports();
      }
    }
  }

  initUser() {
    user.value = userStored(box);
    getUser();
  }

  getUser() async {
    UserModel? userResponse = await userProvider.getProfile();
    if (userResponse is UserModel) {
      user.value = userResponse;
      box.write(userKey, userResponse);
    }
  }

  showNewDialog() {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      barrierDismissible: false,
      const NewSupportView(),
    );
  }

  storeSupport(Map data) async {
    if (Get.isDialogOpen == true) {
      Get.back();
    }
    Get.dialog(
      dialogBdp(
        icon: Icons.save_outlined,
        title: 'Crear nueva caso?',
        btnText: 'Sí, crear',
        action: () async {
          Get.dialog(
            barrierDismissible: false,
            loadingDialog(),
          );
          bool success = await supportProvider.storeSupport(data);
          Get.dialog(
            dialogBdp(
              icon: success ? Icons.check_outlined : Icons.error_outlined,
              title: success
                  ? "Caso Guardado Exitosamente"
                  : "Error al crear el caso",
              btnText: success ? "Aceptar" : null,
              action: () {
                Get.back();
              },
            ),
          );
          if (success) {
            getSupports();
          }
        },
      ),
    );
  }

  setSupport(SupportModel value) {
    supportController.setSupport(
      value,
      userValue: user.value,
    );
    Get.toNamed(Routes.SUPPORT);
  }
}
