import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/auth/auth_cubit.dart';
import 'package:secure_private_notes/model/user_model.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'package:secure_private_notes/widgets/custom_container.dart';
import 'package:secure_private_notes/widgets/custom_text_field.dart';
import 'package:secure_private_notes/widgets/custom_button.dart';
import 'package:secure_private_notes/widgets/small_text.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

import '../../utils/alert_dialog.dart';
import '../../utils/snack_bar.dart';

class UserAccount extends StatefulWidget {
  final UserModel userModel;
  const UserAccount({super.key, required this.userModel});

  @override
  State<UserAccount> createState() => _UserAccountState();
}

class _UserAccountState extends State<UserAccount> {
  String? firstName, lastName;
  final GlobalKey<FormState> formKey = GlobalKey();
  bool readOnly = true;
  validitForm() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      UserModel userModel = UserModel(
          email: widget.userModel.email,
          password: widget.userModel.password,
          firstName: firstName!,
          lastName: lastName!);
      BlocProvider.of<AuthCubit>(context).updateUserInfo(userModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          onTapLeading: () {
            Routes.back(context);
          },
          actionsIcon: readOnly ? Icons.edit : Icons.save,
          onTapActions: () {
            if (!readOnly) {
              validitForm();
            }
            setState(() {
              readOnly = !readOnly;
            });
          },
          leadingIcon: Icons.arrow_back_ios,
          title: const TitlesText(
            text: "Profile",
            size: 20,
          ),
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is SendRestLinkLoading) {
              DialogUtils.showLadingDialog(context);
            } else if (state is SendRestLinkError) {
              Routes.back(context);
              SnackBarUtils.show(
                  context, state.errorMessage!, SnackBarType.failure);
            } else if (state is SendRestLinkSuccess) {
              Routes.back(context);
              SnackBarUtils.show(
                  context, state.successMessage, SnackBarType.success);
            }
          },
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                CustomContainer(
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 2),
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          SmallTexts(
                            text: "First name",
                            size: 15,
                            color: AppStyle.subTitleColor,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              firstName = value;
                            },
                            hint: "Enter your first name",
                            initialValue: widget.userModel.firstName,
                            maxLines: 1,
                            readOnly: readOnly,
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SmallTexts(
                              color: AppStyle.subTitleColor,
                              text: "Last name",
                              size: 15),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              lastName = value;
                            },
                            hint: "Enter your last name",
                            initialValue: widget.userModel.lastName,
                            hintColor: AppStyle.subTitleColor,
                            maxLines: 1,
                            readOnly: readOnly,
                            outlineInputBorder: true,
                            textColor: AppStyle.fontsColor,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SmallTexts(
                              color: AppStyle.subTitleColor,
                              text: "Email",
                              size: 15),
                          const SizedBox(
                            height: 5,
                          ),
                          CustomTextFormField(
                            hint: "Email",
                            initialValue: widget.userModel.email,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.subTitleColor,
                            maxLines: 1,
                            outlineInputBorder: true,
                            readOnly: true,
                          ),
                          const SizedBox(height: 25),
                          CustomButton(
                              onPressed: () async {
                                context
                                    .read<AuthCubit>()
                                    .restPassword(widget.userModel.email);
                              },
                              icon: Icons.lock_outline,
                              text: "Change Password",
                              buttonColor: AppStyle.fontsColor.withOpacity(0.2),
                              textAndIconColor: AppStyle.primaryColor),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomButton(
                            onPressed: () {
                              DialogUtils.show(
                                context,
                                action: "Logout",
                                content: "Are you sure you want to Logout?",
                                onPressed: () {
                                  BlocProvider.of<AuthCubit>(context).signOut();
                                  Routes.back(context);
                                  Routes.back(context);
                                },
                              );
                            },
                            icon: Icons.logout_rounded,
                            text: "Logout",
                            textAndIconColor: AppStyle.warningColor,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
