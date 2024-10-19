import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  GetStorage box = GetStorage('App');
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  initData() {
    initUser();
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

  logout() async {
    await userProvider.logout();
    closeSession();
  }

  destroy() async {
    await userProvider.logout();
    closeSession();
  }

  closeSession() {
    box.remove('token');
    box.remove('user');
    box.erase();
    Get.offAllNamed(Routes.LOGIN);
  }
}
