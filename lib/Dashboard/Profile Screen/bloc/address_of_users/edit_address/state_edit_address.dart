import 'package:smailo/model/profile/address_of_users/edit_address/address_of_use_model.dart';

abstract class EditAddressState {}

class EditAddressInitialState extends EditAddressState {}

class EditAddressLoadingState extends EditAddressState {}

class EditAddressLoadedState extends EditAddressState {
  final EditAddressListModel editAddressList;

  EditAddressLoadedState({required this.editAddressList});
}

class EditAddressErrorState extends EditAddressState {
  final String error;

  EditAddressErrorState({required this.error});
}
