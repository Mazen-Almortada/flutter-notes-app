import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/auth/auth_cubit.dart';
import 'package:secure_private_notes/model/user_model.dart';
import '../../routes/app_routes.dart';
import '../../style/app_style.dart';
import '../../widgets/app_bar.dart';
import '../../widgets/custom_bottom_navigation_bar.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_container.dart';
import '../../widgets/custom_text_field.dart';
import '../../utils/snack_bar.dart';
import '../../widgets/text_widget.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password, confirmedPassword, firstName, lastName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: CustomAppBar(
          leadingIcon: Icons.arrow_back_ios,
          onTapLeading: () {
            Routes.back(context);
          },
        ),
        body: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is CreateAccountError) {
              SnackBarUtils.show(
                  context, state.errorMessage!, SnackBarType.failure);
            }

            if (state is CreateAccountSuccess) {
              SnackBarUtils.show(
                  context, state.successMessage, SnackBarType.success);
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TitlesText(text: "Sign Up", size: 30),
              const SizedBox(
                height: 10,
              ),
              CustomContainer(
                  child: ListView(
                padding: const EdgeInsets.only(top: 30, bottom: 60),
                children: [
                  Form(
                      key: formKey,
                      autovalidateMode: autovalidateMode,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            onSaved: (value) {
                              firstName = value;
                            },
                            hint: "First Name",
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              lastName = value;
                            },
                            hint: "Last Name",
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              email = value;
                            },
                            hint: "Email",
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              password = value;
                            },
                            obscureText: true,
                            hint: "Password",
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomTextFormField(
                            onSaved: (value) {
                              confirmedPassword = value;
                            },
                            obscureText: true,
                            hint: "Confirm Password",
                            outlineInputBorder: true,
                            hintColor: AppStyle.subTitleColor,
                            textColor: AppStyle.fontsColor,
                            maxLines: 1,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButton(
                            onPressed: () async {
                              if (formKey.currentState!.validate()) {
                                formKey.currentState!.save();
                                if (password == confirmedPassword) {
                                  UserModel userModel = UserModel(
                                      firstName: firstName!,
                                      lastName: lastName!,
                                      email: email!,
                                      password: password!);

                                  BlocProvider.of<AuthCubit>(context)
                                      .signUp(userModel);
                                } else {
                                  SnackBarUtils.show(
                                      context,
                                      "Password Do Not Match",
                                      SnackBarType.failure);
                                }
                              } else {
                                autovalidateMode = AutovalidateMode.always;
                                setState(() {});
                              }
                            },
                            icon: Icons.login,
                            text: "Sign Up",
                            textAndIconColor: AppStyle.primaryColor,
                            buttonColor: AppStyle.fontsColor.withOpacity(0.2),
                          ),
                        ],
                      ))
                ],
              ))
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
            buttonText: " Sign In",
            text: "Already have an account?",
            onTap: () => Routes.back(
                  context,
                )));
  }
}
