import 'package:appbdp/app/models/course_model.dart';
import 'package:get/get.dart';

class CourseDetailController extends GetxController {
  final Rx<CourseModel?> course = (null as CourseModel?).obs;

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

  setCourse(CourseModel value) {
    course.value = value;
  }
}
