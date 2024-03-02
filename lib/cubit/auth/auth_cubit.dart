// ignore: import_of_legacy_library_into_null_safe
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_private_notes/services/auth/firebase_auth_service.dart';
import 'package:secure_private_notes/model/user_model.dart';
import 'package:secure_private_notes/services/firestore/firestore_users_service.dart';
import 'package:secure_private_notes/strings/app_strings.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final FirebaseAuthService _authService = FirebaseAuthService();
  final FirestoreUsersService _firestoreUsersService = FirestoreUsersService();

  checkAuth() async {
    emit(AuthLoading());

    FirebaseUser? user = await _authService.getCurrentUser();
    if (user != null) {
      UserModel userModel = await _firestoreUsersService.getUserInfo(user);
      emit(Authenticated(userModel: userModel));
    } else {
      emit(AuthUnAuthenticated());
    }
  }

  signIn(String email, String password) async {
    try {
      await _authService.signIn(email, password);
      await checkAuth();
    } on PlatformException catch (e) {
      emit(AuthError(errorMessage: e.message));
    }
  }

  restPassword(String email) async {
    emit(SendRestLinkLoading());
    try {
      await _authService.restPassword(email);
      emit(SendRestLinkSuccess());
    } on PlatformException catch (e) {
      emit(SendRestLinkError(e.message));
    }
    await checkAuth();
  }

  signUp(UserModel userModel) async {
    try {
      await _authService
          .signUp(userModel.email, userModel.password!)
          .then((_) async {
        FirebaseUser? user = await _authService.getCurrentUser();
        await _firestoreUsersService.setUserInfo(userModel, user!);
      });
      await signOut();
      emit(CreateAccountSuccess());
    } on PlatformException catch (e) {
      emit(CreateAccountError(errorMessage: e.message));
    } catch (e) {
      emit(CreateAccountError(errorMessage: e.toString()));
    }
    await checkAuth();
  }

  updateUserInfo(UserModel userModel) async {
    try {
      FirebaseUser? user = await _authService.getCurrentUser();
      await _firestoreUsersService.updateUserInfo(userModel, user!);
      await checkAuth();
    } on PlatformException catch (e) {
      emit(AuthError(errorMessage: e.message));
    }
  }

  signOut() async {
    await _authService.signOut();
    emit(AuthUnAuthenticated());
  }
}
