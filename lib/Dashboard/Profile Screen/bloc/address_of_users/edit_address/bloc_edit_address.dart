import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/edit_address/event_edit_address.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/edit_address/state_edit_address.dart';
import 'package:smailo/model/profile/address_of_users/edit_address/address_of_use_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class EditAddressBloc extends Bloc<EditAddressEvent, EditAddressState> {
  EditAddressBloc() : super(EditAddressInitialState()) {
    on<FetchEditAddressEvent>(
      (event, emit) async {
        emit(EditAddressLoadingState());
        final EditAddressListModel model = await fetchDataFromApi(
            addressId: event.addressId,
            address: event.address,
            city: event.city,
            country: event.country,
            isDefault: event.isDefault,
            mobileNo: event.mobileNo,
            pinCode: event.pinCode,
            states: event.states);
        try {
          if (model.status == 200) {
            emit(
              EditAddressLoadedState(editAddressList: model),
            );
          } else {
            emit(
              EditAddressErrorState(
                  error: "An Error Occurred When The Fetching Data From Api"),
            );
          }
        } catch (error) {
          emit(
            EditAddressErrorState(error: 'An error Occurred'),
          );
        }
      },
    );
  }

  fetchDataFromApi(
      {required String addressId,
      required String address,
      required String country,
      required String states,
      required String city,
      required pinCode,
      required String isDefault,
      required String mobileNo}) async {
    EditAddressListModel model;
    Map data = {
      'user_id': '177',
      'address_id': addressId,
      'address': address,
      'country': country,
      'state': states,
      'city': city,
      'pincode': pinCode,
      'is_default': isDefault,
      'mobile_no': mobileNo,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}editAddress";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = EditAddressListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
