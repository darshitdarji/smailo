import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/forgot_password/state_forgot_password.dart';
import 'package:smailo/model/authantication/forgot_password/forgot_password_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;
import 'event_forgot_password.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitialState()) {
    on<FetchForgotPasswordEvent>((event, emit) async {
      emit(ForgotPasswordLoadingState());
      final ForgotPasswordListModel model =
          await fetchDataFromApi(phone: event.phone);
      try {
        if (model.status == 200) {
          print("forgotpassword${model.status}");

          emit(
            ForgotPasswordLoadedState(forgotPasswordList: model),
          );
        } else {
          emit(
            ForgotPasswordErrorState(
                error: 'An error Occurred When The Fetching Data From Api'),
          );
        }
      } catch (error) {
        print("forgotpassword${error}");
        emit(
          ForgotPasswordErrorState(error: "An error Occurred"),
        );
      }
    });
  }

  fetchDataFromApi({required String phone}) async {
    ForgotPasswordListModel model;
    Map data = {
      'mobile_and_email': phone,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}forgotPassword";
    final Uri uri = Uri.parse(apiUrl);
    final response = await http.post(uri, body: data);
    print("forgotpassword${response.body}");

    model = ForgotPasswordListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
