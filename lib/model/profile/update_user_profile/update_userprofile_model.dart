class UpdateProfileListModel {
  final int status;
  final UpdateProfileData updateProfileData;
  final String message;

  UpdateProfileListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
          updateProfileData = UpdateProfileData.fromJsonMap(map['data']),
        message = map['message'];
}

class UpdateProfileData {
  final int id;
  final String roleId;
  final String name;
  final String profileImage;
  final String email;
  final String mobileNo;
  final String deviceType;
  final String deviceToken;

  UpdateProfileData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        roleId = map['role_id'],
        name = map['name'],
        profileImage = map['profile_image'],
        email = map['email'],
        mobileNo = map['mobile_no'],
        deviceType = map['device_type'],
        deviceToken = map['device_token'];
}
