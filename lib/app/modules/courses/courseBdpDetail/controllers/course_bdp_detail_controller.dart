import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/modules/courses/courseBdpTopic/controllers/course_bdp_topic_controller.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:get/get.dart';

class CourseBdpDetailController extends GetxController {
  final CourseBdpProvider courseBdpProvider = Get.find();
  final TopicBdpProvider topicBdpProvider = Get.find();
  final CourseBdpTopicController courseBdpTopicController = Get.find();
  final Rx<CourseBdpModel?> course = (null as CourseBdpModel?).obs;
  final RxList<TopicBdpModel> topics = (List<TopicBdpModel>.of([])).obs;
  final loadingTopic = true.obs;

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
      loadingTopic.value = true;
      List<TopicBdpModel>? topicsResponse = await topicBdpProvider.getTopics(
        course.value!.id,
      );
      loadingTopic.value = false;
      if (topicsResponse is List<TopicBdpModel>) {
        topics.value = topicsResponse;
      }
    }
  }

  setTopic(TopicBdpModel topic) {
    courseBdpTopicController.setData(
      course.value!,
      topic,
    );
    Get.toNamed(Routes.COURSE_BDP_TOPIC);
  }
}
