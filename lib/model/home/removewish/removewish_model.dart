class RemoveWishListModel {
  final int status;
  final RemoveWishListModelData removeWishListModelData;
  final String message;

  RemoveWishListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        removeWishListModelData =
            RemoveWishListModelData.fromJsonMap(map['data']),
        message = map['message'];
}

class RemoveWishListModelData {
  final int id;
  final int userId;
  final int productId;
  final String deletedAt;
  final String isFavorite;
  final String createdAt;
  final String updatedAt;

  RemoveWishListModelData.fromJsonMap(Map<String, dynamic> map)
      : userId = map["user_id"],
        productId = map["product_id"],
        deletedAt = map["deleted_at"],
        isFavorite = map["is_favorite"],
        createdAt = map["updated_at"],
        updatedAt = map["created_at"],
        id = map["id"];
}
