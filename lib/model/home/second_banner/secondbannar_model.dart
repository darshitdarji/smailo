class SecondBannerListModel {
  final int status;
  final List<SecondBannerData> secondBannerData;
  final String message;

  SecondBannerListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        secondBannerData = List<SecondBannerData>.from(
            map['data'].map((x) => SecondBannerData.fromJsonMap(x))),
        message = map['message'];
}

class SecondBannerData {
  final int id;
  final String name;
  final String productId;
  final String image;
  final String status;
  final String bannerType;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  SecondBannerData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        productId = map['product_id'],
        image = map['image'],
        status = map['status'],
        bannerType = map['banner_type'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
