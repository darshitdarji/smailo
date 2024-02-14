class BoardListModel {
  final int status;
  final List<BoardData> boardData;
  final String message;

  BoardListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        boardData = List<BoardData>.from(
          map['data'].map(
            (x) => BoardData.fromJsonMap(x),
          ),
        ),
        message = map['message'];
}

class BoardData {
  final int id;
  final String superCategoryId;
  final String name;
  final String image;
  final String status;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;

  BoardData.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        superCategoryId = map['super_category_id'],
        name = map['name'],
        image = map['image'],
        status = map['status'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'];
}
