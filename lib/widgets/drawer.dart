import 'package:flutter/material.dart';
import 'package:secure_private_notes/widgets/blur_background_ui.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/view/account/auth_listener.dart';
import 'package:secure_private_notes/view/backups/backups_screen.dart';
import 'package:secure_private_notes/view/notes/favorites_screen.dart';
import 'package:secure_private_notes/view/passcode/passcode_settings_screen.dart';
import 'package:secure_private_notes/widgets/listtile_items_card.dart';
import 'package:secure_private_notes/view/passcode/passcode_view.dart';
import 'package:secure_private_notes/widgets/radio_button_widget.dart';
import 'package:secure_private_notes/widgets/small_text.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        width: MediaQuery.of(context).size.width,
        child: BlurBackground(
            child: Center(
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Builder(builder: (context) {
                      return IconButton(
                          onPressed: () {
                            Scaffold.of(context).closeDrawer();
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 30,
                            color: AppStyle.warningColor,
                          ));
                    }),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        Routes.to(context, const AuthStatus());
                      },
                      leading: Icon(
                        Icons.account_circle,
                        size: 30,
                        color: AppStyle.secondaryColor,
                      ),
                      title: SmallTexts(
                        text: "Profile",
                        size: 15,
                        color: AppStyle.secondaryColor,
                      )),
                ),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        Routes.to(context, const FavoriteScreen());
                      },
                      leading: Icon(
                        Icons.star,
                        size: 30,
                        color: AppStyle.secondaryColor,
                      ),
                      title: SmallTexts(
                        text: "Favorites",
                        size: 15,
                        color: AppStyle.secondaryColor,
                      )),
                ),
                ItemsCard(
                  child: ExpansionTile(
                    collapsedIconColor: AppStyle.secondaryColor,
                    iconColor: AppStyle.optionalColor,
                    tilePadding: const EdgeInsets.only(right: 10),
                    childrenPadding: const EdgeInsets.only(left: 60),
                    title: ListTile(
                        leading: Icon(
                          Icons.mode_night,
                          size: 30,
                          color: AppStyle.secondaryColor,
                        ),
                        title: SmallTexts(
                          text: "Mode",
                          size: 15,
                          color: AppStyle.secondaryColor,
                        )),
                    children: const [RadioButtonWidget()],
                  ),
                ),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        Routes.to(
                            context,
                            const PasscodeView(
                                routeTo: PasscodeSettingsScreen()));
                      },
                      leading: Icon(
                        Icons.lock,
                        size: 30,
                        color: AppStyle.secondaryColor,
                      ),
                      title: SmallTexts(
                        text: "Lock",
                        size: 15,
                        color: AppStyle.secondaryColor,
                      )),
                ),
                ItemsCard(
                  child: ListTile(
                      onTap: () {
                        Routes.to(context, const BackupScreen());
                      },
                      leading: Icon(
                        Icons.backup,
                        size: 30,
                        color: AppStyle.secondaryColor,
                      ),
                      title: SmallTexts(
                        text: "Backup & Restore",
                        size: 15,
                        color: AppStyle.secondaryColor,
                      )),
                ),
              ],
            ),
          ),
        )));
  }
}
