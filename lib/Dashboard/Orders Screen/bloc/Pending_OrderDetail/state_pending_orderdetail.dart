import 'package:smailo/model/order/pending/Orderdetail/orderdetail_model.dart';

abstract class PendingOrderDetailState {}

class PendingOrderDetailInitialState extends PendingOrderDetailState {}

class PendingOrderDetailLoadingState extends PendingOrderDetailState {}

class PendingOrderDetailLoadedState extends PendingOrderDetailState {
  final PendingOrderDetailListModel pendingOrderDetailList;

  PendingOrderDetailLoadedState({required this.pendingOrderDetailList});
}

class PendingOrderDetailErrorState extends PendingOrderDetailState {
  final String error;

  PendingOrderDetailErrorState({required this.error});
}
