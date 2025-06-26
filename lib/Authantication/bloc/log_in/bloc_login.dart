import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/log_in/event_login.dart';
import 'package:smailo/Authantication/bloc/log_in/state_login.dart';

import 'package:smailo/model/authantication/log_in/login_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class LogInBloc extends Bloc<LogInEvent, UiState> {
  LogInBloc() : super(UiInitialState()) {
    on<FetchLogInEvent>((event, emit) async {
      emit(UiLoadingState());
      final LogInListModel model = await fetchDataFromApi(
        mobile: event.mobile,
        password: event.password,
      );
      try {
        if (model.status == 200) {

          emit(
            UiLoadedState(logInList: model),
          );
        } else {
          emit(
            LogInErrorState(
                error: 'An error Occurred When The Fetching Data From Api'),
          );
        }
      } catch (error) {
        emit(
          LogInErrorState(error: "An error Occurred"),
        );
      }
    });
  }

  fetchDataFromApi({required String mobile, required String password,}) async {
    LogInListModel model;
    // Map data = {
    //   'mobile_and_email': mobile,
    //   'password': password,
    // };
    const apiUrl = "https://theaura.pythonanywhere.com/category/";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri);

    model = LogInListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
