import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:get/get.dart';

class CourseBdpDetailController extends GetxController {
  final CourseBdpProvider courseBdpProvider = Get.find();
  final TopicBdpProvider topicBdpProvider = Get.find();
  final Rx<CourseBdpModel?> course = (null as CourseBdpModel?).obs;
  final RxList<TopicBdpModel> topics = (List<TopicBdpModel>.of([])).obs;

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
  }

  setCourse(CourseBdpModel value) {
    course.value = value;
    getCourse();
    getTopics();
  }

  getCourse() async {
    if (course.value is CourseBdpModel) {
      CourseBdpModel? courseResponse = await courseBdpProvider.getCourse(
        course.value!.id,
      );
      if (courseResponse is CourseBdpModel) {
        course.value = courseResponse;
      }
    }
  }

  getTopics() async {
    if (course.value is CourseBdpModel) {
      List<TopicBdpModel>? topicsResponse = await topicBdpProvider.getTopics(
        course.value!.id,
      );
      if (topicsResponse is List<TopicBdpModel>) {
        topics.value = topicsResponse;
      }
    }
  }
}
