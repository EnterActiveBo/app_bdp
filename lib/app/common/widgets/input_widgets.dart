import 'package:appbdp/app/constants/color.const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';

Widget textFieldBdp({
  FocusNode? focusNode,
  FocusNode? nextNode,
  TextEditingController? textEditingController,
  TextFieldType? textType,
  Widget? prefixIcon,
  String? hintText,
  Widget? suffixIcon,
  BoxConstraints? boxConstraints,
  double? borderRadius,
  double? vertical,
  double? horizontal,
  Color? fillColor,
  Color? borderColor,
  void Function(String)? onChanged,
  String? label,
  Color? labelColor,
  double? labelBottom,
  EdgeInsetsGeometry? margin,
  List<TextInputFormatter>? inputFormatters,
  int? max,
  TextInputType? keyboardType,
  bool? readOnly,
  void Function()? onTap,
}) {
  return Container(
    margin: margin,
    child: AppTextField(
      title: label,
      titleTextStyle: TextStyle(
        color: labelColor ?? appColorPrimary,
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
      controller: textEditingController,
      focus: focusNode,
      nextFocus: nextNode,
      textFieldType: textType ?? TextFieldType.NAME,
      inputFormatters: inputFormatters,
      maxLength: max,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      errorInvalidEmail: "Por favor ingrese un correo electrónico valido.",
      errorThisFieldRequired: "El campo es requerido.",
      errorMinimumPasswordLength:
          "La longitud mínima de la contraseña debe ser $passwordLengthGlobal.",
      onChanged: (value) {
        if (onChanged != null) {
          onChanged(value);
        }
      },
      onTap: onTap,
      suffixIconColor: appColorPrimary,
      cursorColor: appColorPrimary,
      decoration: InputDecoration(
        constraints: boxConstraints,
        filled: true,
        fillColor: fillColor ?? appColorWhite,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            width: 0,
            color: borderColor ?? appColorPrimary,
          ),
          borderRadius: BorderRadius.circular(borderRadius ?? 15),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
          borderSide: BorderSide(
            color: borderColor ?? appColorPrimary,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 14),
          borderSide: BorderSide(
            color: borderColor ?? appColorPrimary,
            width: 1,
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: TextStyle(
          color: labelColor ?? appColorPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        contentPadding: EdgeInsets.symmetric(
          vertical: vertical ?? 15,
          horizontal: horizontal ?? 25,
        ),
      ),
    ),
  );
}

Widget buttonBdp(
  String text,
  void Function() onClick, {
  Color? color,
  Color? textColor,
  double? textSize,
  FontWeight? textWeight,
  double? w,
  double? h,
  FocusNode? focusNode,
}) {
  return ElevatedButton(
    focusNode: focusNode,
    style: ElevatedButton.styleFrom(
      backgroundColor: color ?? appColorThird,
      minimumSize: Size(w ?? Get.width, h ?? 50),
      elevation: 5,
      shadowColor: appColorBlack.withOpacity(.3),
    ),
    onPressed: onClick,
    child: Text(
      text,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontFamily: 'exo2',
        color: textColor ?? appColorWhite,
        fontSize: textSize ?? 18,
        fontWeight: textWeight ?? FontWeight.bold,
      ),
    ),
  );
}
