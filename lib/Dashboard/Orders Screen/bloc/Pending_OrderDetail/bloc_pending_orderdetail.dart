import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/Pending_OrderDetail/event_pending_orderdetail.dart';
import 'package:smailo/Dashboard/Orders%20Screen/bloc/Pending_OrderDetail/state_pending_orderdetail.dart';
import 'package:smailo/model/order/pending/Orderdetail/orderdetail_model.dart';
import 'package:smailo/server_url/base_app_url.dart';
import 'package:http/http.dart' as http;

class PendingOrderDetailBloc
    extends Bloc<PendingOrderDetailEvent, PendingOrderDetailState> {
  PendingOrderDetailBloc() : super(PendingOrderDetailInitialState()) {
    on<FetchPendingOrderDetailEvent>((event, emit) async {
      emit(PendingOrderDetailLoadingState());
      PendingOrderDetailListModel model = await fetchDataFromApi(
          orderId: event.orderId, orderIDEncrypt: event.orderIdEncrypt);
      try {
        if (model.status == 200) {
          emit(PendingOrderDetailLoadedState(pendingOrderDetailList: model));
        } else {
          emit(
            PendingOrderDetailErrorState(
                error: 'An error occurred while fetching data from API'),
          );
        }
      } catch (error) {
        print("PendingOrderDetail error ${error}");
        emit(PendingOrderDetailErrorState(error: 'An error Occurred'));
      }
    });
  }

  fetchDataFromApi(
      {required String orderId, required String orderIDEncrypt}) async {
    PendingOrderDetailListModel model;
    Map data = {
      'user_id': '1760',
      'order_id': orderId,
      'orderIDEncrypt': orderIDEncrypt
    };
    const apiUrl = "${SchoolEcommBaseAppUrl.baseAppUrl}orderDetail";
    final Uri url = Uri.parse(apiUrl);
    final response = await http.post(url, body: data);
    print("PendingOrderDetail response ${response.body}");

    model = PendingOrderDetailListModel.fromJsonMap(
      jsonDecode(response.body),
    );
    return model;
  }
}
