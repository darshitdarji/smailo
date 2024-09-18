class EditAddressListModel {
  final int status;
  final EditAddressData editAddressData;
  final String message;

  EditAddressListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        editAddressData = EditAddressData.fromJsonMap(map['data']),
        message = map['message'];
}

class EditAddressData {
  final int id;
  final String userId;
  final String address;
  final String mobileNo;
  final String country;
  final String state;
  final String city;
  final String pincode;
  final String isDefault;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  EditAddressData.fromJsonMap(Map<String, dynamic> map)
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
