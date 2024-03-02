import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/lock/app_lock_cubit.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/utils/alert_dialog.dart';
import 'package:secure_private_notes/widgets/custom_switch_button.dart';
import 'package:secure_private_notes/widgets/listtile_items_card.dart';
import 'package:secure_private_notes/view/passcode/set_passcode_view.dart';
import 'package:secure_private_notes/utils/snack_bar.dart';
import '../../routes/app_routes.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/text_widget.dart';

class PasscodeSettingsScreen extends StatefulWidget {
  const PasscodeSettingsScreen({super.key});

  @override
  State<PasscodeSettingsScreen> createState() => _PasscodeSettingsScreenState();
}

class _PasscodeSettingsScreenState extends State<PasscodeSettingsScreen> {
  @override
  void initState() {
    super.initState();
  }

  bool isLockOn = false;
  bool isFingerprintOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onTapLeading: () {
          Routes.back(context);
        },
        leadingIcon: Icons.arrow_back_ios,
        title: const TitlesText(
          text: "Lock app",
          size: 20,
        ),
      ),
      body: BlocBuilder<AppLockCubit, AppLockState>(
        builder: (context, state) {
          if (state is AppLockIsOn) {
            isLockOn = true;
            isFingerprintOn = state.isFingerprintOn;
          } else {
            isLockOn = false;
            isFingerprintOn = false;
          }
          return Padding(
            padding: const EdgeInsets.only(right: 10, left: 10, bottom: 10),
            child: ListView(
              children: [
                Center(
                  child: SizedBox(
                      child: Image.asset(
                    "images/lockappicon.png",
                    height: 220,
                  )),
                ),
                ItemsCard(
                    child: ListTile(
                  title: TitlesText(
                    text: "Passcode",
                    size: 15,
                    color: AppStyle.primaryColor,
                  ),
                  trailing: TitlesText(
                    text: isLockOn ? "enabled" : "disabled",
                    size: 12,
                    color: AppStyle.subTitleColor,
                  ),
                )),
                ItemsCard(
                    child: ListTile(
                  title: TitlesText(
                    text: "Unlock with Fingerprint",
                    size: 15,
                    color: AppStyle.primaryColor,
                  ),
                  trailing: CustomSwitch(
                    value: isFingerprintOn,
                    disableColor: AppStyle.subTitleColor,
                    enableColor: AppStyle.primaryColor,
                    onChanged: (value) {
                      if (isLockOn) {
                        BlocProvider.of<AppLockCubit>(context)
                            .changeFingerprintStatus(value);
                      } else {
                        SnackBarUtils.show(
                            context,
                            "You must turn on the passcode",
                            SnackBarType.failure);
                      }
                    },
                  ),
                )),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        if (isLockOn) {
                          DialogUtils.show(
                            context,
                            content:
                                "Are you sure you want to disable passcode",
                            action: 'Turn off',
                            onPressed: () {
                              BlocProvider.of<AppLockCubit>(context)
                                  .changePasscode("");

                              BlocProvider.of<AppLockCubit>(context)
                                  .changeFingerprintStatus(false);
                              Routes.back(context);
                            },
                          );
                        } else {
                          Routes.to(context, const SetPasscodeView());
                        }
                      },
                      title: TitlesText(
                        text:
                            isLockOn ? "Turn Passcode Off" : "Turn Passcode On",
                        size: 15,
                        color: isLockOn
                            ? AppStyle.warningColor
                            : AppStyle.greenColor,
                      )),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
