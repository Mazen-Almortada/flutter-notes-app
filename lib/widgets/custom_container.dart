import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key, required this.child, this.width});
  final double? width;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      width: width,
      padding: const EdgeInsets.fromLTRB(15, 3.7, 15, 2),
      decoration: BoxDecoration(
          // ignore: deprecated_member_use
          color: Theme.of(context).accentColor,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30))),
      child: child,
    ));
  }
}
