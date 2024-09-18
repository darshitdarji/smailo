import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancelled/event_cancellled.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancelled/state_cancelled.dart';
import 'package:smailo/model/order/cancelled/cancelled-model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CancelledBloc extends Bloc<CancelledEvent, CancelledState> {
  CancelledBloc() : super(CancelledInitialState()) {
    on<FetchCancelledEvent>(
      (event, emit) async {
        emit(CancelledLoadingState());
        CancelledListModel model = await fetchDataFromApi();
        try {
          if (model.status == 200) {

            emit(
              CancelledLoadedState(cancelledList: model),
            );
          } else {
            emit(
              CancelledErrorState(
                  error: 'An error occurred while fetching data from API'),
            );
          }
        } catch (error) {
          emit(
            CancelledErrorState(error: 'An Error Occurred'),
          );
        }
      },
    );
  }

  fetchDataFromApi() async {
    CancelledListModel model;
    Map data = {
      'user_id': '610',
      'order_type': '5',
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}orderList";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    print("Cancelled_response${response.body}");

    model = CancelledListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
