import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/confirmed/event_confirmed.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/confirmed/state_confirmed.dart';
import 'package:smailo/model/order/pending/pending_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class ConfirmedBloc extends Bloc<ConfirmedEvent, ConfirmedState> {
  ConfirmedBloc() : super(ConfirmedInitialState()) {
    on<FetchConfirmedEvent>((event, emit) async {
      emit(ConfirmedLoadingState());
      PendingListModel model = await fetchDataFromApi();
      try {
        if (model.status == 200) {
          emit(ConfirmedLoadedState(pendingList: model));
        } else {
          emit(
            ConfirmedErrorState(
                error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        print("Confirmed error${error}");
        emit(ConfirmedErrorState(error: 'An error Occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    PendingListModel model;
    Map data = {
      'user_id': '610',
      'order_type': '2',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}orderList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body:data);
    model = PendingListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
