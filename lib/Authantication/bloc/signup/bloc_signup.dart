import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/signup/event_signup.dart';
import 'package:smailo/Authantication/bloc/signup/state_signup.dart';
import 'package:smailo/model/authantication/Signup/signup_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitialState()) {
    on<FetchSignUpEvent>((event, emit) async {
      emit(SignUpLoadingState());
      SignUpListModel model = await fetchDataFromApi(
        name: event.name,
        conformPassword: event.conformPassword,
        email: event.email,
        mobile: event.mobile,
        password: event.password,
      );

      try {
        if (model.status == 200) {
          print("status_signup${model.status}");

          emit(
            SignUpLoadedState(signUpList: model),
          );
        } else {
          emit(
            SignUpErrorState(
                error: 'An error While The Fetching Data From Api'),
          );
        }
      } catch (error) {
        print("Signuperror${error}");
        emit(
          SignUpErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String conformPassword,
  }) async {
    SignUpListModel model;

    Map data = {
      'name': name,
      'email': email,
      'mobile_no': mobile,
      'password': password,
      'confirm_password': conformPassword,
      'device_token':
          'eI-N29YSQ9mfR1YdjSmQv3:APA91bGIQHKkaW0eSumf0GGaoeh9QGgFfmAGioEudaFiE3Uj7rofQ0Z_TRr-ighHU5_XFGv6dh3HuSdchb9BkJy26YmSScqXSm8-eYE4JuxEaHV5HyWiACJ3SChM7YaIhbaKtJW9ebQn',
      'device_type': '1',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}signup";
    // const apiUrl = "http://localhost:6000/users";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    print("response_signupData${response.body}");
    model = SignUpListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
