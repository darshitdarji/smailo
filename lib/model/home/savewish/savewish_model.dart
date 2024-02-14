
class SaveWishListModel {
  final int status;
  final SaveWishData saveWishData;
  final String message;

  SaveWishListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        saveWishData = SaveWishData.fromJsonMap(map['data']),
        message = map['message'];
}

class SaveWishData {
  final String userId;
  final String productId;
  final String deletedAt;
  final String isFavorite;
  final String updatedAt;
  final String createdAt;
  final int id;

  SaveWishData.fromJsonMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        productId = map['product_id'],
        deletedAt = map['deleted_at'],
        isFavorite = map['is_favorite'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'];
}