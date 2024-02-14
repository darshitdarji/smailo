class AddToCartListModel {
  final int status;
  final List<AddToCartListData> addToCartData;
  final String message;

  AddToCartListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        addToCartData = List<AddToCartListData>.from(
          map['data'].map(
            (x) => AddToCartListData.fromJsonMap(x),
          ),
        ),
        message = map['message'];
}

class AddToCartListData {
  final String userId;
  final String productId;
  final String qty;
  final String isCart;
  final String deletedAt;
  final String updatedAt;
  final String createdAt;
  final int id;

  AddToCartListData.fromJsonMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        productId = map['product_id'],
        qty = map['qty'],
        isCart = map['is_cart'],
        deletedAt = map['deleted_at'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'];
}
