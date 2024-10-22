import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/modules/quotes/controllers/quotes_controller.dart';
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
              ),
              textFieldBdp(
                label: "Teléfono",
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
              ),
              textFieldBdp(
                label: "Correo Electrónico",
                textEditingController: controller.email,
                textType: TextFieldType.EMAIL,
                focusNode: emailFocusNode,
                nextNode: submitFocusNode,
                margin: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                fillColor: appBackgroundOpacity,
                borderColor: appColorTransparent,
                borderRadius: 30,
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
