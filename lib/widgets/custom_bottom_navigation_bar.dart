import 'package:flutter/material.dart';
import 'package:secure_private_notes/widgets/small_text.dart';

import '../style/app_style.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar(
      {super.key, required this.text, required this.buttonText, this.onTap});
  final String text;
  final String buttonText;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmallTexts(
                text: text,
                size: 15,
                bold: false,
                color: AppStyle.subTitleColor),
            GestureDetector(
              onTap: onTap,
              child: SmallTexts(
                text: buttonText,
                size: 15,
                color: AppStyle.optionalColor,
              ),
            ),
          ],
        ));
  }
}
