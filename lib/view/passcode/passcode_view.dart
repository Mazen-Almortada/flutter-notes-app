import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:secure_private_notes/cubit/lock/app_lock_cubit.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';
import '../../utils/local_auth_utils.dart';

class PasscodeView extends StatefulWidget {
  const PasscodeView({super.key, required this.routeTo});
  final Widget routeTo;
  @override
  State<PasscodeView> createState() => _PasscodeViewState();
}

class _PasscodeViewState extends State<PasscodeView> {
  late String storedPasscode;
  bool isFingerprintOn = false;
  bool isAuthenticationSupported = false;

  @override
  void initState() {
    super.initState();
    context.read<AppLockCubit>().checkLockStatus();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocConsumer<AppLockCubit, AppLockState>(
              listener: (context, state) {
                if (state is AppLockIsOff) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget.routeTo,
                      ));
                }
              },
              builder: (context, state) {
                if (state is AppLockIsOn) {
                  isFingerprintOn = state.isFingerprintOn;
                  isAuthenticationSupported = state.isAuthenticationSupported;
                  storedPasscode = state.storedPasscode;

                  return ScreenLock(
                    customizedButtonChild:
                        isAuthenticationSupported && isFingerprintOn
                            ? const Icon(Icons.fingerprint)
                            : null,
                    customizedButtonTap: () async {
                      bool checkAuth =
                          await LocalAuthUtils.showFingerprintAuthDialog(
                              context);
                      if (checkAuth) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => widget.routeTo,
                            ));
                      }
                    },
                    correctString: storedPasscode,
                    title: TitlesText(
                      text: "Enter your passcode",
                      size: 20,
                      color: AppStyle.fontsColor,
                    ),
                    config: ScreenLockConfig(
                        backgroundColor: AppStyle.primaryColor,
                        buttonStyle: OutlinedButton.styleFrom(
                            foregroundColor: AppStyle.fontsColor,
                            side: BorderSide.none,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            backgroundColor: AppStyle.secondaryColor)),
                    useLandscape: true,
                    secretsConfig: SecretsConfig(
                        secretConfig: SecretConfig(
                            borderColor: AppStyle.fontsColor,
                            enabledColor:
                                AppStyle.fontsColor.withOpacity(0.4))),
                    onUnlocked: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => widget.routeTo,
                          ));
                    },
                  );
                } else {
                  return const Center();
                }
              },
            )),
      ],
    );
  }
}
