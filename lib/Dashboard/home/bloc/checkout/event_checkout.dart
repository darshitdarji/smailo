abstract class CheckoutEvent {}

class FetchCheckoutEvent extends CheckoutEvent {
  final String UserAddressId;
  final String couPonId;
  final String paymentType;
  final String totalDiscount;
  final String totalAmount;
  final String offerDiscount;
  final String transactionId;

  FetchCheckoutEvent({
    required this.totalDiscount,
    required this.paymentType,
    required this.transactionId,
    required this.offerDiscount,
    required this.couPonId,
    required this.totalAmount,
    required this.UserAddressId,
  });
}
