abstract class SignUpEvent {}

class FetchSignUpEvent extends SignUpEvent {
  final String email;
  final String mobile;
  final String password;
  final String name;
  final String conformPassword;

  FetchSignUpEvent({
    required this.email,
    required this.name,
    required this.conformPassword,
    required this.mobile,
    required this.password,
  });
}
