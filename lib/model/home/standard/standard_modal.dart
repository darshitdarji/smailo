class StandardListModel {
  final int status;
  List<StandardData>standardData;
  final String message;

  StandardListModel.fromJsonMap(Map<String, dynamic>map)
      : status = map['status'],
        standardData = List<StandardData>.from(
            map['data'].map((x) => StandardData.fromJsonMap(x))),
        message = map['message'];

}

class StandardData {
  final int id;
  final String categoryId;
  final String superCategoryId;
  final String supersubCatId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  StandardData.fromJsonMap(Map<String, dynamic>map)
      : id = map['id'],
        categoryId = map['category_id'],
        superCategoryId = map['super_category_id'],
        supersubCatId = map['supersub_cat_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
