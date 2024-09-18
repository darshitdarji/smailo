import 'package:smailo/model/profile/update_user_profile/update_userprofile_model.dart';

abstract class UpdateUserProfileState {}

class UpdateUserProfileInitialState extends UpdateUserProfileState {}

class UpdateUserProfileLoadingState extends UpdateUserProfileState {}

class UpdateUserProfileLoadedState extends UpdateUserProfileState {
  final UpdateProfileListModel updateProfileList;

  UpdateUserProfileLoadedState({required this.updateProfileList});
}

class UpdateUserProfileErrorState extends UpdateUserProfileState {
  final String error;

  UpdateUserProfileErrorState({required this.error});
}
