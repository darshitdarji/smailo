abstract class AddToCartEvent {}

class FetchAddToCartEvent extends AddToCartEvent {
  final String productId;
  final String quantity;

  FetchAddToCartEvent({required this.productId, required this.quantity});
}

class FetchRemoveToCartEvent extends AddToCartEvent {
  final String productId;

  FetchRemoveToCartEvent({required this.productId});
}
