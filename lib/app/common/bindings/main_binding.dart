import 'package:appbdp/app/common/controllers/main_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class MainBinding extends Bindings {
  @override
  Future<void> dependencies() async {
    await Get.putAsync<MainController>(
      () async {
        await GetStorage.init("App");
        final mainController = MainController();
        return mainController;
      },
      permanent: true,
    );
  }
}
