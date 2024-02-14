class BannerListModel {
  final int status;
  final List<BannerListData> bannerListData;
  final String message;

  BannerListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        bannerListData = List<BannerListData>.from(
            map['data'].map((x) => BannerListData.fromJsonMap(x))),
        message = map['message'];
}

class BannerListData {
  final int id;
  final String name;
  final String productId;
  final String image;
  final String status;
  final String bannerType;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BannerListData.fromJsonMap(Map<String, dynamic> map)
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
