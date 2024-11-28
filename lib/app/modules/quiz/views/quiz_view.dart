import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quiz_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/quiz_controller.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Encuesta",
      ),
      body: Obx(
        () {
          Widget content = Center(
            child: loadingBdp(),
          );
          if (!controller.loading.value) {
            if (controller.responseQuiz.value is QuizResponseModel) {
              String title = "Sus respuestas fueron enviadas exitosamente el ";
              title += dateBdp(controller.responseQuiz.value?.updatedAt) ?? "";
              content = Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: containerBdp(
                  child: titleBdp(
                    title,
                    size: 15,
                    weight: FontWeight.normal,
                  ),
                ),
              );
            } else {
              String currentTitle = controller.getCurrentTitle();
              double quizProgress = controller.quizProgress();

              content = Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 15,
                ),
                child: Column(
                  children: [
                    titleBdp(currentTitle),
                    const SizedBox(
                      height: 10,
                    ),
                    LinearProgressIndicator(
                      value: quizProgress,
                      minHeight: 15,
                      borderRadius: BorderRadius.circular(10),
                      color: appColorThird,
                      backgroundColor: appBackground,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController.value,
                        physics: const NeverScrollableScrollPhysics(),
                        children: controller.quizTabs,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: buttonBdp(
                            "Anterior",
                            () {
                              controller.backQuiz();
                            },
                            color: appColorPrimary,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                bottomLeft: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: buttonBdp(
                            controller.isLastQuiz() ? "Enviar" : "Siguiente",
                            () {
                              if (controller.isLastQuiz()) {
                                controller.sendQuiz();
                              } else {
                                controller.nextQuiz();
                              }
                            },
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }
          return content;
        },
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
