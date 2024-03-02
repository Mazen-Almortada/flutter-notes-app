import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:secure_private_notes/strings/app_strings.dart';
import 'snack_bar.dart';

class LocalAuthUtils {
  static Future<bool> showFingerprintAuthDialog(BuildContext context) async {
    final localAuth = LocalAuthentication();
    final bool canAuth = await isBiometricsSupported();

    if (canAuth) {
      try {
        final bool didauth = await localAuth.authenticate(
            localizedReason: "Authinticate",
            options: const AuthenticationOptions(
              biometricOnly: true,
            ));

        if (didauth) {
          return true;
        }
      } on PlatformException catch (e) {
        String? message;

        switch (e.code) {
          case "PermanentlyLockedOut":
            message = lockedOutMessage;
            localAuth.stopAuthentication();
            break;

          case "LockedOut":
            message = manyAttemptsMessage;
            break;
          default:
            {
              message = somethingErrorMessage;
            }
        }

        // ignore: use_build_context_synchronously
        SnackBarUtils.show(context, message, SnackBarType.failure);
      }
    }
    return false;
  }

  static Future<bool> isBiometricsSupported() async {
    final localAuth = LocalAuthentication();
    final bool canAuthWithBiometrics = await localAuth.canCheckBiometrics;
    final bool canAuth =
        canAuthWithBiometrics || await localAuth.isDeviceSupported();
    return canAuth;
  }
}
