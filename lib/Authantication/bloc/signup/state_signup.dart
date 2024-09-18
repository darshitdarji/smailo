import 'package:smailo/model/authantication/Signup/signup_model.dart';

abstract class SignUpState {}

class SignUpInitialState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpLoadedState extends SignUpState {
  final SignUpListModel signUpList;

  SignUpLoadedState({required this.signUpList});
}

class SignUpErrorState extends SignUpState {
  final String error;

  SignUpErrorState({required this.error});
}
