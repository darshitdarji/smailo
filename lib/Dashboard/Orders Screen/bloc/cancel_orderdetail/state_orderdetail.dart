import 'package:smailo/model/order/cancelled/cancell_oderdetail/cancel_orderdetail_model.dart';

abstract class CancelOrderDetailState {}

class CancelOrderDetailInitialState extends CancelOrderDetailState {}

class CancelOrderDetailLoadingState extends CancelOrderDetailState {}

class CancelOrderDetailLoadedState extends CancelOrderDetailState {
  final CancelOrderDetailModel cancelOrderDetail;

  CancelOrderDetailLoadedState({required this.cancelOrderDetail});
}

class CancelOrderDetailErrorState extends CancelOrderDetailState {
  final String error;

  CancelOrderDetailErrorState({required this.error});
}
