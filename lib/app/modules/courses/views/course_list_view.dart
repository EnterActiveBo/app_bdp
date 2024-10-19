import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/models/course_model.dart';
import 'package:appbdp/app/modules/courses/controllers/courses_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CourseListView extends GetView<CoursesController> {
  const CourseListView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final search = TextEditingController();
    final FocusNode searchFocusNode = FocusNode();
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: 15,
        ),
        child: Column(
          children: [
            searchFilter(
              formKey,
              search: search,
              searchFocusNode: searchFocusNode,
              isFilter: controller.searchCourse.value is String,
              searchAction: (value) {
                controller.setSearchCourse(value);
              },
              action: () {
                if (controller.searchCourse.value is String) {
                  controller.setSearchCourse(null);
                  search.text = "";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: () {
                List<CourseModel> courses = controller.filterCourses();
                return queryBdpWidget(
                  !controller.loadingCourse.value && courses.isNotEmpty,
                  Column(
                    children: courses.asMap().entries.map(
                      (course) {
                        return courseItem(
                          course: course.value,
                          radius: 15,
                          mt: course.key == 0 ? 0 : 15,
                        );
                      },
                    ).toList(),
                  ),
                  loading: controller.loadingCourse.value,
                );
              }(),
            ).expand(),
          ],
        ),
      ),
    );
  }
}
