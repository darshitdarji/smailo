import 'package:smailo/model/authantication/forgot_password/forgot_password_model.dart';

abstract class ForgotPasswordState {}

class ForgotPasswordInitialState extends ForgotPasswordState {}

class ForgotPasswordLoadingState extends ForgotPasswordState {}

class ForgotPasswordLoadedState extends ForgotPasswordState {
  final ForgotPasswordListModel forgotPasswordList;

  ForgotPasswordLoadedState({required this.forgotPasswordList});
}

class ForgotPasswordErrorState extends ForgotPasswordState {
  final String error;

  ForgotPasswordErrorState({required this.error});
}
