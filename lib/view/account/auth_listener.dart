import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/style/app_style.dart';
import 'package:secure_private_notes/view/account/login_screen.dart';
import 'package:secure_private_notes/view/account/profile_screen.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../utils/snack_bar.dart';

class AuthStatus extends StatefulWidget {
  const AuthStatus({super.key});

  @override
  State<AuthStatus> createState() => _AuthStatusState();
}

class _AuthStatusState extends State<AuthStatus> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkAuth();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          SnackBarUtils.show(
              context, state.errorMessage!, SnackBarType.failure);
        }
        if (state is Authenticated) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => UserAccount(userModel: state.userModel!),
              ));
        }
      },
      builder: (context, state) {
        if (state is AuthUnAuthenticated || state is AuthError) {
          return const LoginScreen();
        } else {
          return Center(
              child: CircularProgressIndicator(
            color: AppStyle.greenColor,
          ));
        }
      },
    );
  }
}
