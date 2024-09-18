class CheckoutListModel {
  final int status;
  final CheckoutData checkoutData;
  final String message;

  CheckoutListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        checkoutData = map['data'],
        message = map['message'];
}

class CheckoutData {
  final String userId;
  final String orderNo;
  final String transactionId;
  final String userAddressId;
  final String couponId;
  final String paymentType;
  final String totalDiscount;
  final String shippingCharge;
  final String pickupDate;
  final String totalAmount;
  final String discount;
  final int subTotal;
  final String orderStatus;
  final String deletedAt;
  final String updatedAt;
  final String createdAt;
  final int id;
  final String orderIdEncrypt;

  CheckoutData.fromJsonMap(Map<String, dynamic> map)
      : userId = map['user_id'],
        orderNo = map['order_no'],
        transactionId = map['transaction_id'],
        userAddressId = map['user_address_id'],
        couponId = map['coupon_id'],
        paymentType = map['payment_type'],
        totalDiscount = map['total_discount'],
        shippingCharge = map['shipping_charge'],
        pickupDate = map['pickup_date'],
        totalAmount = map['total_amount'],
        discount = map['discount'],
        subTotal = map['sub_total'],
        orderStatus = map['order_status'],
        deletedAt = map['deleted_at'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'],
        orderIdEncrypt = map['orderIDEncrypt'];
}
