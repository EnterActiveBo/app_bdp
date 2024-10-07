import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/models/providers/banner_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  GetStorage box = GetStorage('App');
  final BannerProvider bannerProvider = Get.find();
  String bannerKey = 'banners';
  final RxList<BannerModel> banners = (List<BannerModel>.of([])).obs;
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;

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
  }

  initData() {
    initUser();
    initBanner();
  }

  initBanner() {
    banners.value = bannersStored(box);
    getBanners();
  }

  getBanners() async {
    List<BannerModel>? bannerResponse = await bannerProvider.getBanners();
    if (bannerResponse is List<BannerModel>) {
      banners.value = bannerResponse;
      box.write(bannerKey, bannerResponse);
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
}
