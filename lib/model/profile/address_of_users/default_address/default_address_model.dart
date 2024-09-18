class DefaultAddressListModel {
  final int status;
  final DefaultAddressData defaultAddressData;
  final String message;

  DefaultAddressListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        defaultAddressData = DefaultAddressData.fromJsonMap(map['data']),
        message = map['message'];
}

class DefaultAddressData {
  final int id;
  final int userId;
  final String address;
  final String mobileNo;
  final String country;
  final String state;
  final String city;
  final int pincode;
  final String isDefault;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  DefaultAddressData.fromJsonMap(Map<String, dynamic> map)
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
