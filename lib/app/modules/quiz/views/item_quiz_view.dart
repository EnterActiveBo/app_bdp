import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/loader_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quiz_model.dart';
import 'package:appbdp/app/modules/quiz/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemQuizView extends GetView<QuizController> {
  final int index;
  final ItemQuizModel quiz;
  const ItemQuizView({
    super.key,
    required this.index,
    required this.quiz,
  });

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    List<Widget> content = [];
    content.addAll(
      [
        titleBdp(quiz.title),
        const SizedBox(
          height: 15,
        ),
        RawScrollbar(
          controller: scrollController,
          thumbVisibility: true,
          radius: const Radius.circular(10),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: SingleChildScrollView(
              controller: scrollController,
              child: Column(
                children: () {
                  List<Widget> items = [];
                  items.addAll(
                    getQuizItems(),
                  );
                  items.addAll(
                    getExtraItems(),
                  );
                  return items;
                }(),
              ),
            ),
          ),
        ).expand(),
      ],
    );

    return containerBdp(
      ph: 0,
      child: Column(
        children: content,
      ),
    );
  }

  List<Widget> getQuizItems() {
    return quiz.options.asMap().entries.map(
      (option) {
        return quizItem(
          option.value,
          mt: option.key == 0 ? 0 : 15,
          selected: quiz.responses.contains(
            option.value,
          ),
          action: () {
            selectOption(option.value);
          },
        );
      },
    ).toList();
  }

  selectOption(String option) {
    if (quiz.responses.contains(option)) {
      quiz.responses.remove(option);
    } else if (quiz.responses.length < quiz.limit) {
      quiz.responses.add(option);
    } else {
      String plural = quiz.limit == 1 ? 'opción' : 'opciones';
      Get.dialog(
        dialogBdp(
          icon: Icons.warning_amber_outlined,
          iconColor: appColorYellow,
          title: 'Solo puede seleccionar ${quiz.limit} $plural.',
          btnText: 'Cerrar',
          btnBackgroundColor: appColorPrimary,
        ),
      );
    }
    controller.setQuizResponse(index, quiz);
  }

  List<Widget> getExtraItems() {
    List<Widget> extraItems = [];
    if (quiz.extra?.isNotEmpty ?? false) {
      extraItems.add(
        const SizedBox(
          height: 15,
        ),
      );
      quiz.extra?.asMap().entries.forEach(
        (extra) {
          extraItems.add(
            textFieldBdp(
              label: extra.value.title,
              textEditingController: extra.value.editController,
              textType: TextFieldType.OTHER,
              margin: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              fillColor: appColorWhite,
              borderColor: appColorPrimary,
              borderRadius: 10,
              isRequired: false,
            ),
          );
        },
      );
    }
    return extraItems;
  }
}
