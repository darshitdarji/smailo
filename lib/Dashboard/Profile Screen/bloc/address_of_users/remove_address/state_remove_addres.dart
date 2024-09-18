import 'package:smailo/model/profile/address_of_users/remove_address/remove_address_model.dart';

abstract class RemoveAddressState {}

class RemoveAddressInitialState extends RemoveAddressState {}

class RemoveAddressLoadingState extends RemoveAddressState {}

class RemoveAddressLoadedState extends RemoveAddressState {
  final RemoveAddressListModel removeAddressList;

  RemoveAddressLoadedState({required this.removeAddressList});
}

class RemoveAddressErrorState extends RemoveAddressState {
  final String error;

  RemoveAddressErrorState({required this.error});
}
