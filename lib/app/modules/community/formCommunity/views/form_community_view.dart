import 'package:appbdp/app/common/widgets/bottom_bdp_view.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/header_bdp_view.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/community_model.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/form_community_controller.dart';

class FormCommunityView extends GetView<FormCommunityController> {
  const FormCommunityView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final FocusNode titleFocus = FocusNode();
    final FocusNode detailFocus = FocusNode();
    final FocusNode submitFocus = FocusNode();

    return Scaffold(
      appBar: const HeaderBdpView(
        primary: true,
        title: "Comunidad",
      ),
      body: Obx(
        () => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment:
                    (controller.community.value is CommunityModel ||
                            controller.reply.value is CommunityModel)
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                children: [
                  Visibility(
                    visible: (controller.community.value == null &&
                        controller.reply.value == null),
                    child: titleBdp(
                      "Nueva Pregunta a la Comunidad",
                    ),
                  ),
                  Visibility(
                    visible: controller.community.value is CommunityModel,
                    child: titleBdp(
                      "Editar Pregunta a la Comunidad",
                    ),
                  ),
                  Visibility(
                    visible: controller.reply.value is CommunityModel,
                    child: textRichBdp(
                      "Respuesta a: ",
                      controller.reply.value?.user.getName() ?? "",
                      titleSize: 16,
                      detailSize: 16,
                      detailColor: appColorThird,
                      detailWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height:
                        controller.community.value is CommunityModel ? 10 : 0,
                  ),
                  textBdp(
                    controller.reply.value?.title,
                    align: TextAlign.left,
                  ),
                  dividerBdp(),
                  textFieldBdp(
                    label: "1. Título",
                    textEditingController: controller.title,
                    textType: TextFieldType.OTHER,
                    focusNode: titleFocus,
                    nextNode: detailFocus,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    fillColor: appBackgroundOpacity,
                    borderColor: appColorTransparent,
                    borderRadius: 30,
                    validator: (String? value) {
                      return (value ?? "").length < 5
                          ? 'Ingrese mínimamente 5 caracteres'
                          : null;
                    },
                  ),
                  textFieldBdp(
                    label: "2. Detalle",
                    textEditingController: controller.detail,
                    textType: TextFieldType.MULTILINE,
                    focusNode: detailFocus,
                    nextNode: submitFocus,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    fillColor: appBackgroundOpacity,
                    borderColor: appColorTransparent,
                    borderRadius: 10,
                    minLines: 3,
                    maxLines: 5,
                    validator: (String? value) {
                      return (value ?? "").length < 10
                          ? 'Ingrese mínimamente 10 caracteres'
                          : null;
                    },
                  ),
                  Row(
                    children: [
                      titleBdp(
                        "3. Recursos Multimedia",
                        weight: FontWeight.normal,
                        align: TextAlign.left,
                        size: 15,
                      ).expand(),
                      GestureDetector(
                        onTap: () {
                          controller.uploadFile();
                        },
                        child: Row(
                          children: [
                            textBdp(
                              "Cargar Recurso",
                              color: appTextLight,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(
                              Icons.add_circle,
                              color: appColorThird,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  containerBdp(
                    mt: 10,
                    ph: controller.sources.isEmpty ? null : 0,
                    pv: controller.sources.isEmpty ? null : 0,
                    backgroundColor:
                        controller.sources.isNotEmpty ? appColorWhite : null,
                    child: () {
                      if (controller.sources.isNotEmpty) {
                        return Column(
                          children: controller.sources.asMap().entries.map(
                            (resource) {
                              return fileItem(
                                resource.value.source,
                                mt: resource.key == 0 ? 0 : 15,
                                icon: Icons.delete_outline,
                                iconColor: appErrorColor,
                                action: () {
                                  controller.removeSource(
                                    resource.key,
                                  );
                                },
                              );
                            },
                          ).toList(),
                        );
                      }
                      return titleBdp(
                        "No existen recursos agregados.",
                        weight: FontWeight.normal,
                        size: 15,
                      );
                    }(),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  buttonBdp(
                    "Publicar",
                    () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        controller.saveCommunity({
                          'title': controller.title.text,
                          'detail': controller.detail.text,
                          'parent_id': controller.reply.value?.id,
                          'sources': controller.sources
                              .map(
                                (e) => e.toSend(),
                              )
                              .toList(),
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const BottomBdpView(),
    );
  }
}
