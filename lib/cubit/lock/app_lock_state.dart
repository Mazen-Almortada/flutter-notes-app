part of 'app_lock_cubit.dart';

abstract class AppLockState {}

class AppLockInitial extends AppLockState {}

class AppLockIsOff extends AppLockState {}

class AppLockIsOn extends AppLockState {
  final bool isFingerprintOn;
  final bool isAuthenticationSupported;
  final String storedPasscode;

  AppLockIsOn(
    this.isFingerprintOn,
    this.storedPasscode,
    this.isAuthenticationSupported,
  );
}
