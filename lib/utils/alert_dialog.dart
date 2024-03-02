import 'package:flutter/material.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/widgets/blur_background_ui.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

class DialogUtils {
  static Future<void> show(BuildContext context,
      {required String content,
      required String action,
      required void Function()? onPressed}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlurBackground(
          child: AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentTextStyle: AppStyle.thirdFont
                .copyWith(fontSize: 18, color: Theme.of(context).primaryColor),
            content: Text(content),
            actions: <Widget>[
              TextButton(
                child: const TitlesText(size: 19, text: 'Cancel'),
                onPressed: () {
                  Routes.back(context);
                },
              ),
              TextButton(
                onPressed: onPressed,
                child: TitlesText(
                  text: action,
                  size: 19,
                  color: AppStyle.warningColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> showLadingDialog(
    BuildContext context,
  ) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BlurBackground(
          child: AlertDialog(
            // titlePadding: const EdgeInsets.only(top: 15),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(color: AppStyle.greenColor),
              ],
            ),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            contentTextStyle: AppStyle.thirdFont
                .copyWith(fontSize: 18, color: Theme.of(context).primaryColor),

            content: const Text(
              "Please Wait",
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }
}
