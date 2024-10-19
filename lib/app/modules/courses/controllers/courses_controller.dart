import 'package:appbdp/app/common/storage_box.dart';
import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:appbdp/app/models/providers/course_bdp_provider.dart';
import 'package:appbdp/app/models/providers/course_provider.dart';
import 'package:appbdp/app/modules/courses/courseBdpDetail/controllers/course_bdp_detail_controller.dart';
import 'package:appbdp/app/modules/courses/courseDetail/controllers/course_detail_controller.dart';
import 'package:appbdp/app/modules/courses/views/course_bdp_list_view.dart';
import 'package:appbdp/app/modules/courses/views/course_list_view.dart';
import 'package:appbdp/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class CoursesController extends GetxController
    with GetTickerProviderStateMixin {
  GetStorage box = GetStorage('App');
  String courseKey = 'courses';
  final CourseProvider courseProvider = Get.find();
  final CourseDetailController courseDetailController = Get.find();
  final RxList<CourseModel> courses = (List<CourseModel>.of([])).obs;
  final Rx<String?> searchCourse = (null as String?).obs;
  final loadingCourse = true.obs;
  String courseBdpKey = 'coursesBdp';
  final CourseBdpProvider courseBdpProvider = Get.find();
  final CourseBdpDetailController courseBdpDetailController = Get.find();
  final RxList<CourseBdpModel> coursesBdp = (List<CourseBdpModel>.of([])).obs;
  final Rx<String?> searchCourseBdp = (null as String?).obs;
  final loadingCourseBdp = true.obs;
  // Tabs definition
  final Rx<TabController?> tabController = (null as TabController?).obs;
  List<Tab> enableTabs = <Tab>[
    const Tab(
      text: "Cursos BDP",
    ),
    const Tab(
      text: "Aula BDP",
    ),
  ];
  List<Widget> tabContents = <Widget>[
    const CourseListView(),
    const CourseBdpListView(),
  ];

  @override
  void onInit() {
    super.onInit();
    tabController.value = TabController(
      vsync: this,
      length: enableTabs.length,
    );
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loadingCourse.value = true;
    searchCourse.value = null;
    searchCourseBdp.value = null;
    loadingCourseBdp.value = true;
  }

  initData() {
    courses.value = coursesStored(box);
    getCourses();
    coursesBdp.value = coursesBdpStored(box);
    getCoursesBdp();
  }

  getCourses() async {
    List<CourseModel>? coursesResponse = await courseProvider.getCourses();
    loadingCourse.value = false;
    if (coursesResponse is List<CourseModel>) {
      courses.value = coursesResponse;
      box.write(courseKey, coursesResponse);
    }
  }

  List<CourseModel> filterCourses() {
    return courses.where((course) {
      bool filter = true;
      if (searchCourse.value is String) {
        filter &= searchString(
          course.title,
          searchCourse.value,
        );
        filter |= searchString(
          course.detail,
          searchCourse.value,
        );
      }
      return filter;
    }).toList();
  }

  setSearchCourse(String? value) {
    searchCourse.value = value == "" ? null : value;
  }

  setCourse(CourseModel value) {
    courseDetailController.setCourse(value);
    Get.toNamed(Routes.COURSE_DETAIL);
  }

  getCoursesBdp() async {
    List<CourseBdpModel>? coursesResponse =
        await courseBdpProvider.getCourses();
    loadingCourseBdp.value = false;
    if (coursesResponse is List<CourseBdpModel>) {
      coursesBdp.value = coursesResponse;
      box.write(courseBdpKey, coursesResponse);
    }
  }

  List<CourseBdpModel> filterCoursesBdp() {
    return coursesBdp.where((course) {
      bool filter = true;
      if (searchCourseBdp.value is String) {
        filter &= searchString(
          course.title,
          searchCourseBdp.value,
        );
      }
      return filter;
    }).toList();
  }

  setSearchCourseBdp(String? value) {
    searchCourseBdp.value = value == "" ? null : value;
  }

  setCourseBdp(CourseBdpModel value) {
    courseBdpDetailController.setCourse(value);
    Get.toNamed(Routes.COURSE_BDP_DETAIL);
  }
}
