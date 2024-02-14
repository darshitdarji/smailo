class MediumListModal {
  final int status;
  final List<MediumData> mediumData;
  final String message;

  MediumListModal.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        mediumData = List<MediumData>.from(
            map['data'].map((x) => MediumData.fromJsonMap(x))),
        message = map['message'];
}

class MediumData {
  final int id;
  final String supersubCatId;
  final String superCategoryId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  MediumData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        supersubCatId = map['supersub_cat_id'],
        superCategoryId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
