abstract class ProductDetailEvent {}

class FetchProductDetailEvent extends ProductDetailEvent {
  final String productId;
  FetchProductDetailEvent({required this.productId});
}
