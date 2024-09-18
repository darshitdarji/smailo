abstract class RemoveAddressEvent {}

class FetchRemoveAddressEvent extends RemoveAddressEvent {
  final String addressId;

  FetchRemoveAddressEvent({required this.addressId});
}
