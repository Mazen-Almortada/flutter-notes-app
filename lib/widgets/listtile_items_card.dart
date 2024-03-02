import 'package:flutter/material.dart';
import 'package:secure_private_notes/style/app_style.dart';

class ItemsCard extends StatelessWidget {
  const ItemsCard({required this.child, this.radius, super.key});
  final Widget child;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.only(top: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 8)),
        color: AppStyle.fontsColor.withOpacity(0.2),
        child: Container(child: child));
  }
}
