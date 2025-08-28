class SchoolModel {
  final int status;
  final List<SchoolData> schoolData;
  final String message;

  SchoolModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        schoolData = List<SchoolData>.from(
            map['data'].map((x) => SchoolData.fromJsonMap(x))),
        message = map['message'];
}

class SchoolData {
  final int id;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  SchoolData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
