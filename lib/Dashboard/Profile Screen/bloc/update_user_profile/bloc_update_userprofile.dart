import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_user_profile/event_update_userprofile.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_user_profile/state_upadate_userprofile.dart';
import 'package:smailo/model/profile/update_user_profile/update_userprofile_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class UpdateUserProfileBloc
    extends Bloc<UpdateUserProfileEvent, UpdateUserProfileState> {
  UpdateUserProfileBloc() : super(UpdateUserProfileInitialState()) {
    on<FetchUpdateUserProfileEvent>((event, emit) async {
      emit(UpdateUserProfileLoadingState());
      final UpdateProfileListModel model = await fetchDataFromApi(
        name: event.name,
        email: event.email,
        mobileNo: event.mobileNo, image: event.image,
      );
      try {
        if (model.status == 200) {
          emit(
            UpdateUserProfileLoadedState(updateProfileList: model),
          );
        } else {
          emit(
            UpdateUserProfileErrorState(
                error: "An error Occurred When the Fetching Data from Api"),
          );
        }
      } catch (error) {

        print("error in Update${error}");
        emit(
          UpdateUserProfileErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi(
      {required String image,
      required String name,
      required String email,
      required String mobileNo}) async {
    UpdateProfileListModel model;
    Map data = {
      'user_id': '610',
      'name': name,
      'mobile_no': mobileNo,
      'email': email,
      'profile_image': image,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}updateUserProfile";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    print("error in Update${response.body}");

    model = UpdateProfileListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
