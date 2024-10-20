import 'package:appbdp/app/common/widgets/input_widgets.dart';
import 'package:appbdp/app/common/widgets/text_widgets.dart';
import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final user = TextEditingController();
    final password = TextEditingController();
    FocusNode userFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    FocusNode submitFocusNode = FocusNode();
    passwordLengthGlobal = 5;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Center(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/login.png',
                    filterQuality: FilterQuality.high,
                    width: Get.width * 0.6,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  titleBdp(
                    "Bienvenido BDP APP",
                    size: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  textFieldBdp(
                    label: "Nombre de Usuario",
                    textEditingController: user,
                    textType: TextFieldType.OTHER,
                    focusNode: userFocusNode,
                    nextNode: passwordFocusNode,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    prefixIcon: const Icon(
                      Icons.alternate_email_outlined,
                      color: appColorPrimary,
                    ),
                    fillColor: appBackground,
                    borderColor: appColorTransparent,
                    borderRadius: 30,
                  ),
                  textFieldBdp(
                    label: "Contraseña",
                    textEditingController: password,
                    textType: TextFieldType.PASSWORD,
                    focusNode: passwordFocusNode,
                    nextNode: submitFocusNode,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: appColorPrimary,
                    ),
                    fillColor: appBackground,
                    borderColor: appColorTransparent,
                    borderRadius: 30,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  buttonBdp(
                    "Iniciar Sesión",
                    () {
                      if (formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        formKey.currentState!.save();
                        controller.login(
                          {
                            'user': user.text,
                            'password': password.text,
                          },
                        );
                      }
                    },
                    focusNode: submitFocusNode,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}