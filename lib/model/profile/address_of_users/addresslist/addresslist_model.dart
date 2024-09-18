class AddressListModel {
  final int status;
  List<AddressListData> addressListData;
  final String message;

  AddressListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        addressListData = List<AddressListData>.from(
          map['data'].map(
            (x) => AddressListData.fromJsonMap(x),
          ),
        ),
        message = map['message'];
}

class AddressListData {
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

  AddressListData.fromJsonMap(Map<String, dynamic> map)
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
