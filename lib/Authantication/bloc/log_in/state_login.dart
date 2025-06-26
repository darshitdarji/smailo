import 'package:smailo/model/authantication/log_in/login_model.dart';

abstract class UiState {}

class UiInitialState extends UiState {}

class UiLoadingState extends UiState {}

class UiLoadedState extends UiState {
  final LogInListModel logInList;

  UiLoadedState({required this.logInList});
}

class LogInErrorState extends UiState {
  final String error;

  LogInErrorState({required this.error});
}
