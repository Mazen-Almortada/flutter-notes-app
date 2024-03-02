import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/auth/auth_cubit.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/view/account/forgot_password_screen.dart';
import 'package:secure_private_notes/view/account/registration_screen.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'package:secure_private_notes/widgets/custom_bottom_navigation_bar.dart';
import 'package:secure_private_notes/widgets/custom_button.dart';
import 'package:secure_private_notes/widgets/custom_container.dart';
import 'package:secure_private_notes/widgets/custom_text_field.dart';
import 'package:secure_private_notes/widgets/text_widget.dart';

import '../../routes/app_routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email, password;

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
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TitlesText(text: "Login", size: 30),
            const SizedBox(
              height: 10,
            ),
            CustomContainer(
                child: ListView(
              padding: const EdgeInsets.only(top: 80, bottom: 60),
              children: [
                Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      children: [
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
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Routes.to(
                                    context, const ForgotPasswordScreen());
                              },
                              child: Text(
                                "Forgot Password?",
                                style: AppStyle.thirdFont
                                    .copyWith(color: AppStyle.optionalColor),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              await BlocProvider.of<AuthCubit>(context)
                                  .signIn(email!, password!);
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                          icon: Icons.login,
                          text: "Sign in",
                          textAndIconColor: AppStyle.primaryColor,
                          buttonColor: AppStyle.fontsColor.withOpacity(0.2),
                        ),
                      ],
                    ))
              ],
            ))
          ],
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          buttonText: " Sign Up",
          text: "Don't have an account?",
          onTap: () {
            Routes.to(context, const RegistrationScreen());
          },
        ));
  }
}
