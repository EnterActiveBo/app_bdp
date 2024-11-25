import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/modules/courses/courseBdpModule/controllers/course_bdp_module_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CourseBdpTopicController extends GetxController {
  final TopicBdpProvider topicBdpProvider = Get.find();
  final CourseBdpModuleController courseBdpModuleController = Get.find();
  final Rx<CourseBdpModel?> course = (null as CourseBdpModel?).obs;
  final Rx<TopicBdpModel?> topic = (null as TopicBdpModel?).obs;
  final RxList<ModuleBdpModel> modules = (List<ModuleBdpModel>.of([])).obs;
  final loadingModules = true.obs;

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
    loadingModules.value = true;
  }

  setData(
    CourseBdpModel courseValue,
    TopicBdpModel topicValue,
  ) {
    course.value = courseValue;
    topic.value = topicValue;
    getModules();
  }

  getModules() async {
    loadingModules.value = true;
    List<ModuleBdpModel>? modulesResponse = await topicBdpProvider.getModules(
      topic.value!.id,
    );
    loadingModules.value = false;
    if (modulesResponse is List<ModuleBdpModel>) {
      modules.value = modulesResponse;
    }
  }

  setModule(ModuleBdpModel module) {
    courseBdpModuleController.setData(
      course.value!,
      topic.value!,
      module,
    );
    Get.toNamed(Routes.COURSE_BDP_MODULE);
  }
}
