import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:get/get.dart';

class CourseBdpModuleController extends GetxController {
  final TopicBdpProvider topicBdpProvider = Get.find();
  final Rx<CourseBdpModel?> course = (null as CourseBdpModel?).obs;
  final Rx<TopicBdpModel?> topic = (null as TopicBdpModel?).obs;
  final Rx<ModuleBdpModel?> module = (null as ModuleBdpModel?).obs;
  final loadingModule = true.obs;

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
    loadingModule.value = true;
  }

  setData(
    CourseBdpModel courseValue,
    TopicBdpModel topicValue,
    ModuleBdpModel moduleValue,
  ) {
    course.value = courseValue;
    topic.value = topicValue;
    module.value = moduleValue;
    getModule();
  }

  getModule() async {
    loadingModule.value = true;
    ModuleBdpModel? moduleResponse = await topicBdpProvider.getModule(
      module.value!.id,
    );
    print(moduleResponse?.getUrl());
    loadingModule.value = false;
    if (moduleResponse is ModuleBdpModel) {
      module.value = moduleResponse;
    }
  }
}
