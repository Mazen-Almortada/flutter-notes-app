import 'package:flutter/material.dart';
import '../style/app_style.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      required this.hint,
      this.maxLines,
      this.onChanged,
      this.hintColor,
      this.textColor,
      this.readOnly = false,
      this.obscureText = false,
      this.initialValue,
      this.outlineInputBorder = false,
      this.onSaved});
  final bool readOnly;
  final bool outlineInputBorder;
  final String hint;
  final bool obscureText;
  final Color? textColor;
  final Color? hintColor;
  final int? maxLines;
  final String? initialValue;
  final void Function(String?)? onSaved;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      initialValue: initialValue,
      keyboardType: maxLines == null ? TextInputType.multiline : null,
      maxLines: maxLines,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: (value) {
        if (value?.isEmpty ?? true) {
          return "Field is required";
        } else {
          return null;
        }
      },
      obscureText: obscureText,
      cursorColor: AppStyle.optionalColor,
      decoration: InputDecoration(
        errorBorder: outlineInputBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppStyle.warningColor),
              )
            : null,
        focusedErrorBorder: outlineInputBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppStyle.warningColor),
              )
            : null,
        contentPadding:
            outlineInputBorder ? const EdgeInsets.fromLTRB(15, 5, 10, 5) : null,
        border: maxLines == null ? InputBorder.none : null,
        enabledBorder: outlineInputBorder
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: AppStyle.subTitleColor),
              )
            : null,
        focusedBorder: maxLines != null
            ? outlineInputBorder
                ? OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: AppStyle.subTitleColor))
                : UnderlineInputBorder(
                    borderSide: BorderSide(color: AppStyle.optionalColor))
            : null,
        hintText: hint,
        hintStyle: AppStyle.thirdFont.copyWith(
            fontSize: 17, color: hintColor, fontWeight: FontWeight.normal),
      ),
      style: AppStyle.primaryFont.copyWith(
          color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
    );
  }
}
