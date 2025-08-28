abstract class CancelOderDetailsEvent {}

class FetchCancelOrderDetailEvent extends CancelOderDetailsEvent {
  final String cancelReason;
  final String orderId;

  FetchCancelOrderDetailEvent(
      {required this.cancelReason, required this.orderId});
}
