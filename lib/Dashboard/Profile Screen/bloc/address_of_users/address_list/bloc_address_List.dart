import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/address_list/event_address_list.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/address_list/state_address_list.dart';
import 'package:smailo/model/profile/address_of_users/addresslist/addresslist_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class AddressListBloc extends Bloc<AddressListEvent, AddressListState> {
  AddressListBloc() : super(AddressListInitialState()) {
    on<FetchAddressListEvent>((event, emit) async {
      emit(AddressListLoadingState());
      final AddressListModel model = await fetchDataFromApi();
      try {
        if (model.status == 200) {
          emit(
            AddressListLoadedState(addressList: model),
          );
        } else {
          emit(
            AddressListErrorState(
                error: "An error Occurred When the Fetching Data from Api"),
          );
        }
      } catch (error) {
        emit(
          AddressListErrorState(error: 'An error Occurred'),
        );
      }
    });
  }

  fetchDataFromApi() async {
    AddressListModel model;
    Map data = {
      'user_id': '177',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}addressList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = AddressListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
