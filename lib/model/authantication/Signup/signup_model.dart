class SignUpListModel {
  final int status;
  final SignUpData signUpData;
  final String message;

  SignUpListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        signUpData = SignUpData.fromJsonMap(map['data']),
        message = map['message'];
}

class SignUpData {
  final String name;
  final String roleId;
  final String profileImage;
  final String mobileNo;
  final String mobileOtp;
  final String email;
  final String status;
  final String deletedAt;
  final String updatedAt;
  final String createdAt;
  final int id;

  SignUpData.fromJsonMap(Map<String, dynamic> map)
      : name = map['name'],
        roleId = map['role_id'],
        profileImage = map['profile_image'],
        mobileNo = map['mobile_no'],
        mobileOtp = map['mobile_otp'],
        email = map['email'],
        status = map['status'],
        deletedAt = map['deleted_at'],
        updatedAt = map['updated_at'],
        createdAt = map['created_at'],
        id = map['id'];
}
