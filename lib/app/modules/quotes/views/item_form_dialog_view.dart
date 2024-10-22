import 'dart:io';

import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:appbdp/app/models/quote_model.dart';
import 'package:appbdp/app/modules/quotes/controllers/quotes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

class ItemFormDialogView extends GetView<QuotesController> {
  final ItemQuoteModel? item;
  final int? index;
  const ItemFormDialogView({
    super.key,
    this.item,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final item = TextEditingController();
    FocusNode itemFocus = FocusNode();
    final price = TextEditingController();
    FocusNode priceFocus = FocusNode();
    final quantity = TextEditingController();
    FocusNode quantityFocus = FocusNode();
    FocusNode submitFocus = FocusNode();
    if (this.item is ItemQuoteModel) {
      item.text = this.item!.item;
      price.text = this.item!.price.toString();
      quantity.text = this.item!.quantity.toString();
    }

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
                        "Item",
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
                        label: "Nombre del Item",
                        textEditingController: item,
                        textType: TextFieldType.OTHER,
                        focusNode: itemFocus,
                        nextNode: priceFocus,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        fillColor: appBackgroundOpacity,
                        borderColor: appColorTransparent,
                        borderRadius: 30,
                        validator: (String? value) {
                          return (value ?? "").length < 3
                              ? 'Ingrese mínimamente 3 caracteres'
                              : null;
                        },
                      ),
                      textFieldBdp(
                        label: "Precio",
                        textEditingController: price,
                        textType: TextFieldType.NUMBER,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        focusNode: priceFocus,
                        nextNode: quantityFocus,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        fillColor: appBackgroundOpacity,
                        borderColor: appColorTransparent,
                        borderRadius: 30,
                      ),
                      textFieldBdp(
                        label: "Cantidad",
                        textEditingController: quantity,
                        textType: TextFieldType.NUMBER,
                        keyboardType: TextInputType.numberWithOptions(
                          signed: Platform.isIOS,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        focusNode: quantityFocus,
                        nextNode: submitFocus,
                        margin: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        fillColor: appBackgroundOpacity,
                        borderColor: appColorTransparent,
                        borderRadius: 30,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      buttonBdp(
                        "Guardar",
                        () {
                          if (formKey.currentState!.validate()) {
                            formKey.currentState!.save();
                            ItemQuoteModel newItem = ItemQuoteModel(
                              item: item.text,
                              price: double.parse(price.text),
                              quantity: int.parse(quantity.text),
                            );
                            controller.itemAction(
                              newItem,
                              index: index,
                            );
                          }
                        },
                        focusNode: submitFocus,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      buttonBdp(
                        "Cerrar",
                        () {
                          Get.back();
                        },
                        color: appColorPrimary,
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
