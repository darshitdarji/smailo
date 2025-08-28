abstract class EditAddressEvent {}

class FetchEditAddressEvent extends EditAddressEvent {
  final String addressId;
  final String address;
  final String country;
  final String states;
  final String city;
  final String pinCode;
  final String isDefault;
  final String mobileNo;

  FetchEditAddressEvent(
      {required this.addressId,
      required this.states,
      required this.isDefault,
      required this.pinCode,
      required this.city,
      required this.country,
      required this.address,
      required this.mobileNo});
}
