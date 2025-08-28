import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/event_user_profile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/user_profile/state_user_profile.dart';
import 'package:smailo/model/profile/edit_profile/user_profile_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class EditUserProfileBloc extends Bloc<UserProfileEvent, EditUserProfileState> {
  EditUserProfileBloc() : super(UserProfileInitialState()) {
    on<FetchUserProfileEvent>((event, emit) async {
      emit(EditUserProfileLoadingState());
      final UserListModel model = await fetchDataFromApi();
      try {
        if (model.status == 200) {
          emit(
            EditUserProfileLoadedState(userList: model),
          );
        } else {
          emit(
            EditUserProfileErrorState(
              error: 'An error Occurred While Fetching Data From Api',
            ),
          );
        }
      } catch (error) {
        emit(
          EditUserProfileErrorState(error: "An error Occurred"),
        );
      }
    });
  }

  fetchDataFromApi() async {
    UserListModel model;
    Map data = {
      'user_id': '1760',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}userProfile";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    model = UserListModel.fromSjonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
