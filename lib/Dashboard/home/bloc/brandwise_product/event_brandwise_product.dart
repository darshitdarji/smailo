abstract class BrandWiseEvent {}

class FetchBrandwiseEvent extends BrandWiseEvent {
  final String brandId;

  FetchBrandwiseEvent({
    required this.brandId,
  });
}
