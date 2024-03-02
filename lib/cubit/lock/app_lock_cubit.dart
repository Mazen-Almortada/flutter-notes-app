import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../utils/local_auth_utils.dart';
import '../../../utils/passcode_preferences.dart';
part 'app_lock_state.dart';

class AppLockCubit extends Cubit<AppLockState> {
  AppLockCubit() : super(AppLockInitial());

  checkLockStatus() async {
    bool isFingerprintOn =
        await PasscodePreferences.isUnlockWithFingerprintOn();

    String storedPasscode = await PasscodePreferences.getPasscode();
    bool isAuthenticationSupported =
        await LocalAuthUtils.isBiometricsSupported();
    if (storedPasscode == "") {
      emit(AppLockIsOff());
    } else {
      emit(AppLockIsOn(
          isFingerprintOn, storedPasscode, isAuthenticationSupported));
    }
  }

  changeFingerprintStatus(bool fingerprintUnlock) async {
    await PasscodePreferences.unlockWithFingerprint(fingerprintUnlock);
    await checkLockStatus();
  }

  changePasscode(String enteredPasscode) async {
    await PasscodePreferences.setPasscode(enteredPasscode);
    await checkLockStatus();
  }
}
