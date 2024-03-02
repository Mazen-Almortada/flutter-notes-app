// ignore: import_of_legacy_library_into_null_safe
import 'package:shared_preferences/shared_preferences.dart';

class PasscodePreferences {
  static Future<void> setPasscode(String enteredPasscode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("passcode", enteredPasscode);
  }

  static Future<void> unlockWithFingerprint(bool fingerprintUnlock) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setBool("fingerprint_unlock", fingerprintUnlock);
  }

  static Future<bool> isUnlockWithFingerprintOn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("fingerprint_unlock") ?? false;
  }

  static Future<String> getPasscode() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedPasscode = prefs.getString("passcode") ?? "";

    return storedPasscode;
  }
}
