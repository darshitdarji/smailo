import 'package:smailo/model/authantication/resend_otp/model_resend_otp.dart';

abstract class ResendOtpState {}

class ResendOtpInitialState extends ResendOtpState {}

class ResendOtpLoadingState extends ResendOtpState {}

class ResendOtpLoadedState extends ResendOtpState {
  final ResendOtpModel resendOtpList;

  ResendOtpLoadedState({required this.resendOtpList});
}

class ResendOtpErrorState extends ResendOtpState {
  final String error;

  ResendOtpErrorState({required this.error});
}
