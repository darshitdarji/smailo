abstract class UpdateUserProfileEvent {}

class FetchUpdateUserProfileEvent extends UpdateUserProfileEvent {
  final String name;
  final String email;
  final String mobileNo;
  final String image;

  FetchUpdateUserProfileEvent({
    required this.mobileNo,
    required this.email,
    required this.image,
    required this.name,
  });
}
