abstract class ForgotPasswordEvent {}

class FetchForgotPasswordEvent extends ForgotPasswordEvent {
  final String phone;

  FetchForgotPasswordEvent({required this.phone});
}
