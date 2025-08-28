import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Authantication/bloc/resend_otp/event_resend_otp.dart';
import 'package:smailo/Authantication/bloc/resend_otp/state_resend_otp.dart';
import 'package:smailo/model/authantication/resend_otp/model_resend_otp.dart';
import 'package:http/http.dart' as http;
import '../../../server_url/base_app_url.dart';

class ResendOtpBloc extends Bloc<ResendOtpEvent, ResendOtpState> {
  ResendOtpBloc() : super(ResendOtpInitialState()) {
    on<FetchResendOtpEvent>((event, emit) async {
      emit(ResendOtpLoadingState());
      final ResendOtpModel model = await fetchDataFromApi();
      try {
        if (model.status == 200) {
          emit(
            ResendOtpLoadedState(
              resendOtpList: model,
            ),
          );
        } else {
          emit(
            ResendOtpErrorState(
              error: 'An error Occurred When The Fetching Data From Api',
            ),
          );
        }
      } catch (error) {
        emit(
          ResendOtpErrorState(error: "An error Occurred"),
        );
      }
    });
  }

  fetchDataFromApi() async {
    ResendOtpModel model;
    Map data = {
      'user_id': '1760',
      'device_token':
          'cyPMaIC0RVCdLJvdgEl2bB:APA91bHSYtbSb6Xcr1zKAJ2PQdqKkIfxnnxr-qfSRvy26qjIlUUjYgfUkeRzeywNrvDkhQ2kHy5SlvRCn50izQgpMDs--0GpKBy-woge9eOHa76g6X55oLRNXXc0ZnGuk_SDFtiiq2mY',
      'device_type': '1'
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}resendOtp";
    Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = ResendOtpModel.fromJsonMap(
      jsonDecode(
        response.body,
      ),
    );
    return model;
  }
}
