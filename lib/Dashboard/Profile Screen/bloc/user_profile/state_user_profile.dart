import 'package:smailo/model/profile/edit_profile/user_profile_model.dart';

abstract class EditUserProfileState {}

class UserProfileInitialState extends EditUserProfileState {}

class EditUserProfileLoadingState extends EditUserProfileState {}

class EditUserProfileLoadedState extends EditUserProfileState {
  final UserListModel userList;

  EditUserProfileLoadedState({required this.userList});
}

class EditUserProfileErrorState extends EditUserProfileState {
  final String error;

  EditUserProfileErrorState({required this.error});
}
