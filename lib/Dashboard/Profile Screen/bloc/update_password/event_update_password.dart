abstract class UpdatePasswordEvent {}

class FetchUpdatePasswordEvent extends UpdatePasswordEvent {
  final String password;
  final String conformPassword;

  FetchUpdatePasswordEvent(
      {required this.conformPassword, required this.password});
}
