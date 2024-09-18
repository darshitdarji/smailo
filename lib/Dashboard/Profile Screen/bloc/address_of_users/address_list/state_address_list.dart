import 'package:smailo/model/profile/address_of_users/addresslist/addresslist_model.dart';

abstract class AddressListState {}

class AddressListInitialState extends AddressListState {}

class AddressListLoadingState extends AddressListState {}

class AddressListLoadedState extends AddressListState {
  final AddressListModel addressList;

  AddressListLoadedState({required this.addressList});
}

class AddressListErrorState extends AddressListState {
  final String error;

  AddressListErrorState({required this.error});
}
