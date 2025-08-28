abstract class LogInEvent {}

class FetchLogInEvent extends LogInEvent {
  final String mobile;
  final String password;
  final String image;

  FetchLogInEvent(
      {required this.mobile, required this.password, required this.image});
}
