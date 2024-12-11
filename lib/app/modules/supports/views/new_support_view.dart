import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/modules/supports/controllers/supports_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class NewSupportView extends GetView<SupportsController> {
  const NewSupportView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final title = TextEditingController();
    FocusNode titleFocus = FocusNode();
    final detail = TextEditingController();
    FocusNode detailFocus = FocusNode();
    FocusNode submitFocus = FocusNode();

    return SingleChildScrollView(
      child: Dialog(
        backgroundColor: appColorTransparent,
        child: Container(
          decoration: BoxDecoration(
            color: appColorWhite,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16),
            boxShadow: defaultBoxShadow(),
          ),
          width: Get.width,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: appColorPrimary,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      titleBdp(
                        "Nuevo Caso",
                        align: TextAlign.left,
                      ).expand(),
                      GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.close,
                            color: appErrorColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  child: Column(
                    children: [
                      textFieldBdp(
                        label: "Título del Caso",
                        textEditingController: title,
                        textType: TextFieldType.OTHER,
                        focusNode: titleFocus,
                        nextNode: detailFocus,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        fillColor: appBackgroundOpacity,
                        borderColor: appColorTransparent,
                        borderRadius: 30,
                        max: 50,
                        validator: (String? value) {
                          return (value ?? "").length < 3
                              ? 'Ingrese mínimamente 3 caracteres'
                              : null;
                        },
                      ),
                      textFieldBdp(
                        label: "Descripción",
                        textEditingController: detail,
                        textType: TextFieldType.MULTILINE,
                        focusNode: detailFocus,
                        nextNode: submitFocus,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        fillColor: appBackgroundOpacity,
                        borderColor: appColorTransparent,
                        borderRadius: 10,
                        max: 300,
                        validator: (String? value) {
                          return (value ?? "").length < 10
                              ? 'Ingrese mínimamente 10 caracteres'
                              : null;
                        },
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buttonBdp(
                        "Crear Nuevo",
                        () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            controller.storeSupport({
                              'title': title.text,
                              'detail': detail.text,
                            });
                          }
                        },
                        focusNode: submitFocus,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
