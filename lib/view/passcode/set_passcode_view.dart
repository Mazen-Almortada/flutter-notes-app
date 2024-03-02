import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';
import 'package:secure_private_notes/cubit/lock/app_lock_cubit.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

class SetPasscodeView extends StatefulWidget {
  const SetPasscodeView({super.key});

  @override
  State<SetPasscodeView> createState() => _SetPasscodeViewState();
}

class _SetPasscodeViewState extends State<SetPasscodeView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ScreenLock.create(
            config: ScreenLockConfig(
                backgroundColor: AppStyle.primaryColor,
                buttonStyle: OutlinedButton.styleFrom(
                    foregroundColor: AppStyle.fontsColor,
                    side: BorderSide.none,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    backgroundColor: AppStyle.secondaryColor)),
            title: TitlesText(
              text: "Enter new passcode",
              size: 20,
              color: AppStyle.fontsColor,
            ),
            confirmTitle: TitlesText(
              text: "Confirm new passcode",
              size: 20,
              color: AppStyle.fontsColor,
            ),
            useLandscape: true,
            secretsConfig: SecretsConfig(
                secretConfig: SecretConfig(
                    borderColor: AppStyle.fontsColor,
                    enabledColor: AppStyle.fontsColor.withOpacity(0.4))),
            onConfirmed: (value) async {
              BlocProvider.of<AppLockCubit>(context).changePasscode(value);
              Routes.back(context);
            },
          ),
        ),
      ],
    );
  }
}
