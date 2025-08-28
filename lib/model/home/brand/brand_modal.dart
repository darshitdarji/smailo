class BrandListModel {
  final int status;
  List<BrandData> branData;
  final String message;

  BrandListModel.fromJasonMap(Map<String, dynamic> map)
      : status = map['status'],
        branData = List<BrandData>.from(
            map['data'].map((x) => BrandData.fromJsonMap(x))),
        message = map['message'];
}

class BrandData {
  final int id;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BrandData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
