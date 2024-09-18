class RemoveAddressListModel {
  final int status;
  final RemoveAddressData removeAddressData;
  final String message;

  RemoveAddressListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        removeAddressData = RemoveAddressData.fromJsonMap(map['data']),
        message = map['message'];
}

class RemoveAddressData {
  final int id;
  final int userId;
  final String address;
  final String mobileNo;
  final String country;
  final String state;
  final String city;
  final int pincode;
  final int isDefault;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  RemoveAddressData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        userId = map['user_id'],
        address = map['address'],
        mobileNo = map['mobile_no'],
        country = map['country'],
        state = map['state'],
        city = map['city'],
        pincode = map['pincode'],
        isDefault = map['is_default'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
