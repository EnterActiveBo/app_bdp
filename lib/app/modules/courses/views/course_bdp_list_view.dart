import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/models/course_bdp_model.dart';
import 'package:appbdp/app/modules/courses/controllers/courses_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class CourseBdpListView extends GetView<CoursesController> {
  const CourseBdpListView({super.key});
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
              isFilter: controller.searchCourseBdp.value is String,
              searchAction: (value) {
                controller.setSearchCourseBdp(value);
              },
              action: () {
                if (controller.searchCourseBdp.value is String) {
                  controller.setSearchCourseBdp(null);
                  search.text = "";
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              child: () {
                List<CourseBdpModel> courses = controller.filterCoursesBdp();
                return queryBdpWidget(
                  !controller.loadingCourseBdp.value && courses.isNotEmpty,
                  Column(
                    children: courses.asMap().entries.map(
                      (course) {
                        return courseItem(
                          courseBdp: course.value,
                          imageW: 75,
                          radius: 15,
                          mt: course.key == 0 ? 0 : 15,
                          action: () {
                            controller.setCourseBdp(course.value);
                          },
                        );
                      },
                    ).toList(),
                  ),
                  loading: controller.loadingCourseBdp.value,
                );
              }(),
            ).expand(),
          ],
        ),
      ),
    );
  }
}
