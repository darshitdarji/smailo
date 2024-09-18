import 'package:smailo/model/authantication/log_in/login_model.dart';

abstract class LogInState {}

class LogInInitialState extends LogInState {}

class LogInLoadingState extends LogInState {}

class LogInLoadedState extends LogInState {
  final LogInListModel logInList;

  LogInLoadedState({required this.logInList});
}

class LogInErrorState extends LogInState {
  final String error;

  LogInErrorState({required this.error});
}
