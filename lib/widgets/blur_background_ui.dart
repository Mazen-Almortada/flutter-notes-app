import 'package:flutter/material.dart';
import '../style/app_style.dart';
import 'dart:ui';

class BlurBackground extends StatelessWidget {
  const BlurBackground({required this.child, super.key});

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: 8,
              color: AppStyle.fontsColor.withOpacity(0.3),
              spreadRadius: 5,
              offset: const Offset(0, 3)),
        ],
      ),
      child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), child: child),
    );
  }
}
