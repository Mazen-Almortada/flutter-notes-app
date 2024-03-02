import 'package:flutter/material.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

import '../style/app_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {required this.onPressed,
      required this.icon,
      required this.text,
      required this.textAndIconColor,
      this.buttonColor,
      this.size = 20,
      super.key});
  final void Function()? onPressed;

  final Color? buttonColor;
  final String text;
  final double size;
  final Color? textAndIconColor;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: MediaQuery.of(context).size.width,
      // ignore: deprecated_member_use
      color: buttonColor ?? Theme.of(context).accentColor,
      elevation: 1,
      shape: OutlineInputBorder(
          borderSide: BorderSide(color: buttonColor ?? AppStyle.warningColor),
          borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitlesText(
              text: text,
              color: textAndIconColor,
              size: size,
            ),
            const SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              color: textAndIconColor,
            )
          ],
        ),
      ),
    );
  }
}
