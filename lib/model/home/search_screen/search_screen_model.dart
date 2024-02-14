class SearchListModel {
  final int status;
  final SearchData searchData;
  final int totalPages;
  final int totalCount;
  final int pageNumber;
  final bool hasNextPage;
  final bool hasPreviousPage;
  final String message;

  SearchListModel.fromJsonMap(Map<String, dynamic> map)
      : status = map['status'],
        searchData = SearchData.fromJsonMap(map['data']),
        totalPages = map['totalPages'],
        totalCount = map['totalCount'],
        pageNumber = map['pageNumber'],
        hasNextPage = map['hasNextPage'],
        hasPreviousPage = map['hasPreviousPage'],
        message = map['message'];
}

class SearchData {
  final List<SearchDataList> searchDataList;

  SearchData.fromJsonMap(Map<String, dynamic> map)
      : searchDataList = List<SearchDataList>.from(
          map['productData'].map(
            (x) => SearchDataList.fromJsonMap(x),
          ),
        );
}

class SearchDataList {
  final int id;
  final String productName;
  final String superCatId;
  final String superSubCatId;
  final String categoryId;
  final String subCategoryId;
  final String productImage;
  final int brandId;
  final String price;
  final String quantity;
  final String description;
  final String discount;
  final String discountPrice;
  final String soldBy;
  final String status;
  final String isFuture;
  final String createdAt;
  final String updatedAt;
  final String deletedAt;
   String isCart;
  final String brandName;

  SearchDataList.fromJsonMap(Map<String, dynamic> map)
      : id = map['id'],
        productName = map['product_name'],
        superCatId = map['super_cat_id'],
        superSubCatId = map['super_sub_cat_id'],
        categoryId = map['category_id'],
        subCategoryId = map['sub_category_id'],
        productImage = map['product_image'],
        brandId = map['brand_id'],
        price = map['price'],
        quantity = map['quantity'],
        description = map['description'],
        discount = map['discount'],
        discountPrice = map['discount_price'],
        soldBy = map['sold_by'],
        status = map['status'],
        isFuture = map['is_future'],
        createdAt = map['created_at'],
        updatedAt = map['updated_at'],
        deletedAt = map['deleted_at'],
        isCart = map['is_cart'],
        brandName = map['brand_name'];
}
