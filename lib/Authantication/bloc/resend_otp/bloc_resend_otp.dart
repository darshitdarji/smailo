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
          emit(ResendOtpLoadedState(resendOtpList: model,),);
        } else {
          emit(ResendOtpErrorState(
            error: 'An error Occurred When The Fetching Data From Api',),);
        }
      } catch (error){
        emit(ResendOtpErrorState(error: "An error Occurred"),);
      }
    });
  }

  fetchDataFromApi() async {
    ResendOtpModel model;
    Map data = {
      'user_id': '610',
      'device_token': 'cR_qCkrlTFqrqMubw59R9A:APA91bET1zfBeADvpCN72Xbm2iqI540o0WNN7B-Dp3jFTzo3Y4Ch49IZVw56ypdY6RxEPyvh3MmnPWoqZgakG7LnZ_ikDjhJabTm7HkdmCpj_R2ttbdnepxAtLVS9ObdQGfowoTIPbyL',
      'device_type': '1'
    };

    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}resendOtp";
    Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = ResendOtpModel.fromJsonMap(jsonDecode(response.body,),);
    return model;
  }
}