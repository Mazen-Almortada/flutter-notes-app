import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/cubit/auth/auth_cubit.dart';
import 'package:secure_private_notes/routes/app_routes.dart';
import 'package:secure_private_notes/utils/alert_dialog.dart';
import 'package:secure_private_notes/utils/snack_bar.dart';
import 'package:secure_private_notes/widgets/app_bar.dart';
import 'package:secure_private_notes/widgets/custom_text_field.dart';
import 'package:secure_private_notes/widgets/small_text.dart';

import '../../style/app_style.dart';
import '../../widgets/custom_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          leadingIcon: Icons.arrow_back_ios,
          onTapLeading: () {
            Routes.back(context);
          },
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
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 40, left: 20, right: 20, bottom: 10),
                  child: Form(
                    key: formKey,
                    autovalidateMode: autovalidateMode,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SmallTexts(
                            color: Theme.of(context).primaryColor,
                            text: "Rest Password",
                            size: 20),
                        const SizedBox(
                          height: 20,
                        ),
                        SmallTexts(
                            bold: false,
                            color: Theme.of(context).primaryColor,
                            text:
                                "Enter the email address associated with your account and we'll send you a link to rest your password.",
                            size: 15),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          onSaved: (value) {
                            email = value;
                          },
                          hint: "Email",
                          outlineInputBorder: true,
                          hintColor: AppStyle.subTitleColor,
                          textColor: Theme.of(context).primaryColor,
                          maxLines: 1,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              formKey.currentState!.save();
                              context.read<AuthCubit>().restPassword(email!);
                            } else {
                              autovalidateMode = AutovalidateMode.always;
                              setState(() {});
                            }
                          },
                          icon: Icons.send_rounded,
                          size: 15,
                          text: "Send Password Rest Link",
                          textAndIconColor: AppStyle.primaryColor,
                          buttonColor: AppStyle.fontsColor.withOpacity(0.2),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
