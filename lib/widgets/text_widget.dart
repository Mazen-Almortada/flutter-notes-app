import 'package:flutter/material.dart';
import 'package:secure_private_notes/style/app_style.dart';

class TitlesText extends StatelessWidget {
  final String text;
  final double size;
  final Color? color;
  final bool bold;
  const TitlesText(
      {required this.text,
      required this.size,
      this.color,
      this.bold = true,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15),
      child: Text(
        text,
        softWrap: true,
        style: AppStyle.secondaryFont.copyWith(
            color: color ?? Theme.of(context).primaryColor,
            fontSize: size,
            fontWeight: bold ? FontWeight.bold : null),
      ),
    );
  }
}
