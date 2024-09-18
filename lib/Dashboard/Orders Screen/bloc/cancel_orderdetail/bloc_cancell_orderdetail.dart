import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancel_orderdetail/event_orderdetail.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/cancel_orderdetail/state_orderdetail.dart';
import 'package:smailo/model/order/cancelled/cancell_oderdetail/cancel_orderdetail_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class CancelledOrderDetailsBloc
    extends Bloc<CancelOderDetailsEvent, CancelOrderDetailState> {
  CancelledOrderDetailsBloc() : super(CancelOrderDetailInitialState()) {
    on<FetchCancelOrderDetailEvent>(
      (event, emit) async {
        emit(CancelOrderDetailLoadingState());
        CancelOrderDetailModel model = await fetchDataFromApi(cancelReason: event.cancelReason, orderId: event.orderId);
        try {
          if (model.status == 200) {
            print("Cancelled_orderDetail_response${model.status}");

            emit(
              CancelOrderDetailLoadedState(cancelOrderDetail: model),
            );
          } else {
            emit(
              CancelOrderDetailErrorState(
                  error: 'An error occurred while fetching data from API'),
            );
          }
        } catch (error) {
          print("Cancelled OrderDetail${error}");
          emit(
            CancelOrderDetailErrorState(error: 'An Error Occurred'),
          );
        }
      },
    );
  }

  fetchDataFromApi(
      {required String cancelReason, required String orderId}) async {
    CancelOrderDetailModel model;
    Map data = {
      'user_id': '610',
      'cancel_reason': cancelReason,
      'order_id': orderId,
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}cancelOrder";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    print("Cancelled_orderDetail_response${response.body}");

    model = CancelOrderDetailModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
