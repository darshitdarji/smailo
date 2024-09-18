import 'package:smailo/model/profile/update_password/update_password_model.dart';

abstract class UpdatePasswordState {}

class UpdatePasswordInitialState extends UpdatePasswordState {}

class UpdatePasswordLoadingState extends UpdatePasswordState {}

class UpdatePasswordLoadedState extends UpdatePasswordState {
  final UpdatePasswordListModel updatePasswordList;

  UpdatePasswordLoadedState({required this.updatePasswordList});
}

class UpdatePasswordErrorState extends UpdatePasswordState {
  final String error;

  UpdatePasswordErrorState({required this.error});
}
