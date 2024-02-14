class HomeCountListModel {
  final int status;
  final CountData countData;
  final String message;

  HomeCountListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        countData = CountData.fromJsonMap(map['data']),
        message = map['message'];
}

class CountData {
  final int cartCount;
  final int favoriteCount;
  final int orderCount;

  CountData.fromJsonMap(Map<String, dynamic> map)
      : cartCount = map['cartCount'],
        favoriteCount = map['favoriteCount'],
        orderCount = map['orderCount'];
}
