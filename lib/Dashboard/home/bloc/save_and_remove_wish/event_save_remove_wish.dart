abstract class SaveAndRemoveWishEvent {}

class FetchSaveWishEvent extends SaveAndRemoveWishEvent {
  final String productId;

  FetchSaveWishEvent({required this.productId});
}

class FetchRemoveWishEvent extends SaveAndRemoveWishEvent {
  final String wishListId;

  FetchRemoveWishEvent({required this.wishListId});
}
