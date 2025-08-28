import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_password/event_update_password.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/update_password/state_update_password.dart';
import 'package:smailo/model/profile/update_password/update_password_model.dart';
import 'package:smailo/server_url/base_app_url.dart';

class UpdatePasswordBloc
    extends Bloc<UpdatePasswordEvent, UpdatePasswordState> {
  UpdatePasswordBloc() : super(UpdatePasswordInitialState()) {
    on<FetchUpdatePasswordEvent>((event, emit) async {
      final UpdatePasswordListModel model = await fetchDataFromApi(
          password: event.password, conformPassword: event.conformPassword);
      emit(UpdatePasswordLoadingState());
      try {
        if (model.status == 200) {
          emit(
            UpdatePasswordLoadedState(updatePasswordList: model),
          );
        } else {
          emit(
            UpdatePasswordErrorState(
                error: 'An Error occurred While Fetching Data From Api'),
          );
        }
      } catch (error) {
        print("An UpdatePassword${error}");
        emit(
          UpdatePasswordErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi(
      {required String password, required String conformPassword}) async {
    UpdatePasswordListModel model;
    Map data = {
      'user_id': '1760',
      'password': password,
      're_enter_password': conformPassword,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}changePassword";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    print("error in Update${response.body}");

    model = UpdatePasswordListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
