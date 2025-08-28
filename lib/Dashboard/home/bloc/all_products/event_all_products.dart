abstract class AllProductsEvent {}

class FetchAllProductEvent extends AllProductsEvent {
  final String filterPrice;
  final String filterShortBy;

  FetchAllProductEvent(
      {required this.filterPrice, required this.filterShortBy});
}
