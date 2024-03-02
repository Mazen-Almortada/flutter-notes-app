import 'package:flutter/material.dart';
import 'package:secure_private_notes/style/app_style.dart';

class SmallTexts extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final bool bold;
  const SmallTexts(
      {required this.text,
      required this.size,
      this.color,
      this.bold = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: AppStyle.thirdFont.copyWith(
          // ignore: deprecated_member_use
          color: color ?? Theme.of(context).accentColor,
          fontSize: size,
          fontWeight: bold ? FontWeight.bold : null),
    );
  }
}
