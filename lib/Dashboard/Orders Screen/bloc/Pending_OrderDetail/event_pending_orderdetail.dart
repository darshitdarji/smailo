abstract class PendingOrderDetailEvent {}

class FetchPendingOrderDetailEvent extends PendingOrderDetailEvent {
  final String orderId;
  final String orderIdEncrypt;

  FetchPendingOrderDetailEvent(
      {required this.orderId, required this.orderIdEncrypt});
}
