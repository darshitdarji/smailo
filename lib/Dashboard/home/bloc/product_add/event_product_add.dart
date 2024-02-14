abstract class ProductAddEvent {}

class FetchProductAdd extends ProductAddEvent {
  final String standardId;

  FetchProductAdd({required this.standardId});
}
