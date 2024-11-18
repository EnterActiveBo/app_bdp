import 'package:appbdp/app/common/utils.dart';
import 'package:appbdp/app/common/widgets/element_widgets.dart';
import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/items_widgets.dart';
import 'package:appbdp/app/common/widgets/query_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/user_model.dart';
import 'package:appbdp/app/modules/quotes/controllers/quotes_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class NewView extends GetView<QuotesController> {
  const NewView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final buyer = TextEditingController();
    FocusNode buyerFocusNode = FocusNode();
    buyer.text = controller.newQuote.value.buyer ?? "";
    final quoteAt = TextEditingController();
    FocusNode quoteAtFocus = FocusNode();
    quoteAt.text = dateBdp(controller.newQuote.value.quoteAt) ?? "";

    return Obx(
      () => SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 15,
            ),
            child: queryBdpWidget(
              controller.user.value?.seller is SellerModel,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  titleBdp(
                    "1. Datos del comprador",
                    align: TextAlign.left,
                  ),
                  textFieldBdp(
                    label: "Nombre Empresa/Negocio",
                    textEditingController: buyer,
                    textType: TextFieldType.OTHER,
                    focusNode: buyerFocusNode,
                    nextNode: quoteAtFocus,
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
                    label: "Fechas",
                    readOnly: true,
                    textEditingController: quoteAt,
                    textType: TextFieldType.NAME,
                    focusNode: quoteAtFocus,
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    prefixIcon: const Icon(
                      Icons.calendar_month_outlined,
                      color: appColorPrimary,
                    ),
                    fillColor: appBackgroundOpacity,
                    borderColor: appColorTransparent,
                    borderRadius: 30,
                    vertical: 0,
                    horizontal: 0,
                    onTap: () async {
                      DateTime current = DateTime.now();
                      final DateTime? dateSelect = await showDatePicker(
                        context: context,
                        initialDate: controller.newQuote.value.quoteAt,
                        firstDate: current,
                        lastDate: DateTime(
                          current.year,
                          12,
                          31,
                        ),
                        locale: const Locale("es", "BO"),
                      );
                      if (dateSelect is DateTime) {
                        quoteAt.text = "${dateBdp(dateSelect)}";
                      }
                    },
                  ),
                  dividerBdp(
                    color: appColorPrimary,
                  ),
                  Row(
                    children: [
                      titleBdp(
                        "2. Ítems",
                        align: TextAlign.left,
                      ).expand(),
                      GestureDetector(
                        onTap: () {
                          controller.showItemDialog();
                        },
                        child: Row(
                          children: [
                            textBdp(
                              "Agregar Ítem",
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
                  const SizedBox(
                    height: 10,
                  ),
                  queryBdpWidget(
                    controller.newQuote.value.items.isNotEmpty,
                    Column(
                      children:
                          controller.newQuote.value.items.asMap().entries.map(
                        (item) {
                          return newItemQuote(
                            item.value,
                            mt: item.key == 0 ? 0 : 10,
                            edit: () {
                              controller.showItemDialog(
                                index: item.key,
                                item: item.value,
                              );
                            },
                            delete: () {
                              controller.showDeleteItem(item.key);
                            },
                          );
                        },
                      ).toList(),
                    ),
                    textColor: appTextNormal,
                    textWeight: FontWeight.normal,
                    textFamily: 'helvetica',
                    message: "Por favor agregue ítems antes de continuar.",
                  ),
                  dividerBdp(
                    color: appColorPrimary,
                  ),
                  Row(
                    children: [
                      titleBdp("Total:"),
                      titleBdp(
                        "Bs ${priceFormat(controller.newQuote.value.total())}",
                        align: TextAlign.right,
                      ).expand(),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  buttonBdp(
                    "Crear Nueva Cotización",
                    () {
                      if (formKey.currentState!.validate()) {
                        formKey.currentState!.save();
                        if (controller.newQuote.value.items.isNotEmpty) {
                          controller.saveQuote({
                            "buyer": buyer.text,
                            "quote_at": quoteAt.text,
                            "items": controller.newQuote.value.items
                                .map(
                                  (x) => x.toJson(),
                                )
                                .toList(),
                          });
                        } else {
                          Get.snackbar(
                            "Formulario Incompleto",
                            "Por favor agregue ítems antes de continuar.",
                            icon: const Icon(
                              Icons.error_outline,
                              color: appColorWhite,
                              size: 35,
                            ),
                            colorText: appColorWhite,
                            backgroundColor: appErrorColor,
                            duration: const Duration(minutes: 1),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 20,
                            ),
                            margin: const EdgeInsets.all(10),
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buttonBdp(
                    "Limpiar Datos",
                    () {
                      controller.cleanNewQuote();
                    },
                    color: appColorPrimary,
                  ),
                ],
              ),
              loading: controller.user.value is! UserModel,
              message:
                  "Complete su información de vendedor antes de continuar.",
            ),
          ),
        ),
      ),
    );
  }
}
