import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/event_pending.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/pending/state_pending.dart';
import 'package:smailo/model/order/pending/pending_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class PendingBloc extends Bloc<PendingEvent, PendingState> {
  PendingBloc() : super(PendingInitialState()) {
    on<FetchPendingEvent>((event, emit) async {
      emit(PendingLoadingState());
      PendingListModel model = await fetchDataFromApi();
      try {
        if (model.status == 200) {

          emit(PendingLoadedState(pendingList: model));
        } else {
          emit(
            PendingErrorState(
                error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        emit(PendingErrorState(error: 'An error Occurred'));
      }
    });
  }

  fetchDataFromApi() async {
    PendingListModel model;
    Map data = {
      'user_id': '610',
      'order_type': '1',
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
