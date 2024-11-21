import 'dart:io';

import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/banner_model.dart';
import 'package:appbdp/app/modules/quotes/controllers/quotes_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class SellerView extends GetView<QuotesController> {
  const SellerView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    FocusNode nameFocusNode = FocusNode();
    FocusNode addressFocusNode = FocusNode();
    FocusNode phoneFocusNode = FocusNode();
    FocusNode emailFocusNode = FocusNode();
    FocusNode termsFocusNode = FocusNode();
    FocusNode submitFocusNode = FocusNode();

    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleBdp(
                "1. Datos del Vendedor",
                align: TextAlign.left,
              ),
              textFieldBdp(
                label: "Nombre Empresa/Negocio *",
                textEditingController: controller.name,
                textType: TextFieldType.NAME,
                focusNode: nameFocusNode,
                nextNode: addressFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
              ),
              textFieldBdp(
                label: "Dirección",
                textEditingController: controller.address,
                textType: TextFieldType.OTHER,
                focusNode: addressFocusNode,
                nextNode: phoneFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
                isRequired: false,
              ),
              textFieldBdp(
                label: "Teléfono o Celular",
                textEditingController: controller.phone,
                textType: TextFieldType.PHONE,
                focusNode: phoneFocusNode,
                nextNode: emailFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
                isRequired: false,
              ),
              textFieldBdp(
                label: "Correo Electrónico",
                textEditingController: controller.email,
                textType: TextFieldType.EMAIL,
                focusNode: emailFocusNode,
                nextNode: termsFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
                isRequired: false,
              ),
              textFieldBdp(
                label: "Términos y Condiciones",
                textEditingController: controller.terms,
                textType: TextFieldType.MULTILINE,
                focusNode: termsFocusNode,
                nextNode: submitFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
                isRequired: false,
              ),
              Row(
                children: [
                  titleBdp(
                    "Logo",
                    weight: FontWeight.normal,
                    align: TextAlign.left,
                    size: 15,
                  ).expand(),
                  GestureDetector(
                    onTap: () {
                      controller.uploadImage();
                    },
                    child: Row(
                      children: [
                        textBdp(
                          "Cargar Imagen",
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
              Obx(
                () => containerBdp(
                  mt: 10,
                  child: queryBdpWidget(
                    !controller.loadingUser.value,
                    () {
                      if (controller.imageSeller.value is FilePickerResult) {
                        return Column(
                          children: controller.imageSeller.value!.files.map(
                            (img) {
                              return Image.file(
                                File(img.xFile.path),
                                height: 150,
                                fit: BoxFit.cover,
                              );
                            },
                          ).toList(),
                        );
                      }
                      if (controller.user.value?.seller?.image is FileModel) {
                        return CachedNetworkImage(
                          imageUrl: controller.user.value!.seller!.image!.url,
                          fit: BoxFit.cover,
                          height: 150,
                        );
                      }
                      return titleBdp(
                        "No existe una imagen guardada.",
                        weight: FontWeight.normal,
                        size: 15,
                      );
                    }(),
                    loading: true,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              buttonBdp(
                "Guardar Datos",
                () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    controller.saveSeller({
                      'name': controller.name.text,
                      'address': controller.address.text,
                      'phone': controller.phone.text,
                      'email': controller.email.text,
                      'terms': controller.terms.text,
                      'image_id': controller.image.text,
                    });
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
