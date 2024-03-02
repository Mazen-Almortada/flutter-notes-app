part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthUnAuthenticated extends AuthState {}

class Authenticated extends AuthState {
  final UserModel? userModel;
  Authenticated({this.userModel});
}

class AuthError extends AuthState {
  final String? errorMessage;
  AuthError({this.errorMessage});
}

class CreateAccountError extends AuthState {
  final String? errorMessage;
  CreateAccountError({this.errorMessage});
}

class CreateAccountSuccess extends AuthState {
  final String successMessage = accountCreatedMessage;
}

class SendRestLinkLoading extends AuthState {}

class SendRestLinkError extends AuthState {
  final String? errorMessage;
  SendRestLinkError(this.errorMessage);
}

class SendRestLinkSuccess extends AuthState {
  final String successMessage = passwordRestLinkMessage;
}
