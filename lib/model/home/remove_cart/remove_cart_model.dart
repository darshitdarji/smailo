class RemoveToCartListModel {
  final int status;
  final RemoveCartListData removeCartListData;
  final String message;

  RemoveToCartListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        removeCartListData = RemoveCartListData.fromJsonMap(map['data']),
        message = map['message'];
}

class RemoveCartListData {
  final int id;
  final String userId;
  final String productId;
  final String qty;
  final String isCart;
  final String offerId;
  final String isGlobalOffer;
  final String deletedAt;
  final String createdAt;
  final String updatedAt;

  RemoveCartListData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        productId = map['product_id'],
        qty = map['qty'],
        isCart = map['is_cart'],
        offerId = map['offer_id'],
        isGlobalOffer = map['is_global_offer'],
        deletedAt = map['deleted_at'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'];
}