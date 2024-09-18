  abstract class LogInEvent {}

class FetchLogInEvent extends LogInEvent {
  final String mobile;
  final String password;

  FetchLogInEvent({required this.mobile, required this.password});
}
