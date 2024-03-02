import 'package:flutter/material.dart';

import '../style/app_style.dart';
import '../widgets/small_text.dart';

enum SnackBarType { success, failure }

class SnackBarUtils {
  static void show(BuildContext context, String message, SnackBarType type) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        duration: const Duration(milliseconds: 3000),
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: type == SnackBarType.success
                  ? AppStyle.greenColor.withOpacity(0.8)
                  : AppStyle.warningColor.withOpacity(0.8)),
          margin: const EdgeInsets.only(bottom: 5, right: 15, left: 15),
          height: 60,
          child: ListTile(
            title: SmallTexts(
              text: message,
              size: 10,
              color: AppStyle.primaryColor,
            ),
            trailing: Icon(
              type == SnackBarType.success ? Icons.done : Icons.error,
              color: AppStyle.primaryColor,
            ),
          ),
        )));
  }
}
