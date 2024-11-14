import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/models/gatip_model.dart';
import 'package:appbdp/app/models/providers/gatip_provider.dart';
import 'package:appbdp/app/models/providers/user_provider.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class WeatherController extends GetxController {
  GetStorage box = GetStorage('App');
  final UserProvider userProvider = Get.find();
  String userKey = 'user';
  final Rx<UserModel?> user = (null as UserModel?).obs;
  final GatipProvider gatipProvider = Get.find();
  final Rx<WeatherModel?> weather = (null as WeatherModel?).obs;
  final loadingWeather = true.obs;

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
    loadingWeather.value = true;
    super.onClose();
  }

  initData() {
    initUser();
    getWeather();
  }

  getWeather() async {
    loadingWeather.value = true;
    WeatherModel? response = await gatipProvider.getAgroClimatic();
    loadingWeather.value = false;
    if (response is WeatherModel) {
      weather.value = response;
      weather.refresh();
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
