import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/providers/quiz_provider.dart';
import 'package:appbdp/app/models/quiz_model.dart';
import 'package:appbdp/app/modules/quiz/views/item_quiz_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QuizController extends GetxController with GetTickerProviderStateMixin {
  GetStorage box = GetStorage('App');
  String quizKey = "quiz_response";
  final QuizProvider quizProvider = Get.find();
  final loading = true.obs;
  final Rx<QuizModel?> quiz = (null as QuizModel?).obs;
  final Rx<QuizResponseModel?> responseQuiz = (null as QuizResponseModel?).obs;
  final Rx<TabController?> tabController = (null as TabController?).obs;
  final RxList<Widget> quizTabs = (List<Widget>.of([])).obs;

  @override
  void onInit() {
    super.onInit();
    initData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    loading.value = true;
  }

  initData() {
    getQuiz();
  }

  getQuiz() async {
    loading.value = true;
    QuizModel? quizResponse = await quizProvider.getCurrent();
    if (quizResponse is QuizModel) {
      quiz.value = quizResponse;
      await getResponse();
      initTab();
    }
    loading.value = false;
  }

  getResponse() async {
    loading.value = true;
    QuizResponseModel? quizResponse = await quizProvider.responseQuiz(
      quiz.value!.code,
    );
    if (quizResponse is QuizResponseModel) {
      responseQuiz.value = quizResponse;
      box.write(quizKey, quizResponse);
    }
    loading.value = false;
  }

  initTab() {
    if (quiz.value is QuizModel && responseQuiz.value is! QuizResponseModel) {
      setQuizTab();
      tabController.value = TabController(
        vsync: this,
        length: quizTabs.length,
      );
    }
  }

  setQuizTab() {
    quizTabs.clear();
    quizTabs.addAll(
      quiz.value!.form.asMap().entries.map(
        (item) {
          return ItemQuizView(
            index: item.key,
            quiz: item.value,
          );
        },
      ).toList(),
    );
    quizTabs.refresh();
  }

  backQuiz() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (tabController.value is TabController &&
        tabController.value!.index > 0) {
      tabController.value!.animateTo(tabController.value!.index - 1);
    }
    tabController.refresh();
  }

  nextQuiz() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (tabController.value is TabController &&
        tabController.value!.index < quiz.value!.form.length - 1) {
      ItemQuizModel item = quiz.value!.form[tabController.value!.index];
      if (item.isReady()) {
        tabController.value!.animateTo(tabController.value!.index + 1);
      } else {
        Get.dialog(
          dialogBdp(
            icon: Icons.warning_amber_outlined,
            iconColor: appColorYellow,
            title: 'Debe seleccionar mínimamente 1 opción antes de continuar.',
            btnText: 'Cerrar',
            btnBackgroundColor: appColorPrimary,
          ),
        );
      }
    }
    tabController.refresh();
  }

  sendQuiz() async {
    if (quiz.value!.readyToSave()) {
      Get.dialog(
        dialogBdp(
          icon: Icons.save_outlined,
          title: '¿Esta seguro de enviar la información?',
          btnText: 'Sí, enviar',
          action: () async {
            Get.dialog(
              barrierDismissible: false,
              loadingDialog(),
            );
            bool success = await quizProvider.setQuiz(
              quiz.value!.toStore(),
            );
            Get.dialog(
              dialogBdp(
                icon: success ? Icons.check_outlined : Icons.error_outlined,
                title: success
                    ? "Gracias sus respuestas fueron registradas exitosamente"
                    : "Error al Guardar las respuestas, por favor intente nuevamente",
                btnText: success ? "Salir" : null,
                action: () {
                  Get.back();
                },
              ),
            );
            if (success) {
              getResponse();
            }
          },
        ),
      );
    } else {
      Get.dialog(
        dialogBdp(
          icon: Icons.warning_amber_outlined,
          iconColor: appColorYellow,
          title: 'Debe seleccionar mínimamente 1 opción antes de continuar.',
          btnText: 'Cerrar',
          btnBackgroundColor: appColorPrimary,
        ),
      );
    }
  }

  bool isLastQuiz() {
    if (tabController.value is TabController) {
      return tabController.value!.index == quiz.value!.form.length - 1;
    }
    return false;
  }

  String getCurrentTitle() {
    if (quiz.value is QuizModel && responseQuiz.value is! QuizResponseModel) {
      return "Pregunta ${tabController.value!.index + 1} de ${quiz.value!.form.length}";
    }
    return "";
  }

  double quizProgress() {
    if (tabController.value is TabController && quiz.value is QuizModel) {
      return (tabController.value!.index + 1) / quiz.value!.form.length;
    }
    return 0;
  }

  setQuizResponse(int index, ItemQuizModel value) {
    quiz.value!.form[index] = value;
    quiz.refresh();
    setQuizTab();
  }

  setExtraResponse(int index, int indexExtra, ExtraQuizModel value) {
    quiz.value!.form[index].extra![indexExtra] = value;
    quiz.refresh();
    setQuizTab();
  }
}
