import 'package:flutter/material.dart';

class Routes {
  static void to(BuildContext context, dynamic page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static void back(BuildContext context) {
    Navigator.pop(context);
  }
}
