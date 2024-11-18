import 'package:appbdp/app/models/course_model.dart';
import 'package:get/get.dart';

class CourseDetailController extends GetxController {
  final Rx<CourseModel?> course = (null as CourseModel?).obs;




  setCourse(CourseModel value) {
    course.value = value;
  }
}
