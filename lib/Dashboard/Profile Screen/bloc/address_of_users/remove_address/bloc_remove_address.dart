import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/remove_address/event_remove_address.dart';
import 'package:smailo/Dashboard/Profile%20Screen/bloc/address_of_users/remove_address/state_remove_addres.dart';
import 'package:smailo/model/profile/address_of_users/remove_address/remove_address_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class RemoveAddressBloc extends Bloc<RemoveAddressEvent, RemoveAddressState> {
  RemoveAddressBloc() : super(RemoveAddressInitialState()) {
    on<FetchRemoveAddressEvent>(
      (event, emit) async {
        emit(RemoveAddressLoadingState());
        final RemoveAddressListModel model = await fetchDataFromApi(
          addressId: event.addressId,
        );
        try {
          if (model.status == 200) {
            emit(
              RemoveAddressLoadedState(removeAddressList: model),
            );
          } else {
            emit(
              RemoveAddressErrorState(
                  error: "An Error Occurred When The Fetching Data From Api"),
            );
          }
        } catch (error) {
          emit(
            RemoveAddressErrorState(error: 'An error Occurred'),
          );
        }
      },
    );
  }

  fetchDataFromApi({required String addressId}) async {
    RemoveAddressListModel model;
    Map data = {
      'user_id': '1760',
      'address_id': addressId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}removeAddress";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    model = RemoveAddressListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
