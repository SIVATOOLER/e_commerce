// To parse this JSON data, do
//
//     final allProductModel = allProductModelFromJson(jsonString);

import 'dart:convert';

AllProductModel allProductModelFromJson(String str) => AllProductModel.fromJson(json.decode(str));

String allProductModelToJson(AllProductModel data) => json.encode(data.toJson());

class AllProductModel {
  Data data;
  int count;
  int total;
  int currentPage;
  int lastPage;

  AllProductModel({
    required this.data,
    required this.count,
    required this.total,
    required this.currentPage,
    required this.lastPage,
  });

  factory AllProductModel.fromJson(Map<String, dynamic> json) => AllProductModel(
    data: Data.fromJson(json["data"]),
    count: json["count"],
    total: json["total"],
    currentPage: json["currentPage"],
    lastPage: json["lastPage"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "count": count,
    "total": total,
    "currentPage": currentPage,
    "lastPage": lastPage,
  };
}

class Data {
  List<ProductList> productList;

  Data({
    required this.productList,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productList: List<ProductList>.from(json["product_list"].map((x) => ProductList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "product_list": List<dynamic>.from(productList.map((x) => x.toJson())),
  };
}

class ProductList {
  int productId;
  int categoryId;
  String categoryName;
  String productName;
  String productPrice;
  String productDiscount;
  String productImage;
  dynamic isFavourite;

  ProductList({
    required this.productId,
    required this.categoryId,
    required this.categoryName,
    required this.productName,
    required this.productPrice,
    required this.productDiscount,
    required this.productImage,
    required this.isFavourite,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    productId: json["product_id"],
    categoryId: json["category_id"],
    categoryName: json["category_name"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    productImage: json["product_image"],
    isFavourite: json["is_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "category_id": categoryId,
    "category_name": categoryName,
    "product_name": productName,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "product_image": productImage,
    "is_favourite": isFavourite,
  };
}

enum CategoryName {
  ELEGANT_SILK,
  SOFT_SILK,
  WEDDING_SILK
}

final categoryNameValues = EnumValues({
  "Elegant Silk": CategoryName.ELEGANT_SILK,
  "Soft Silk": CategoryName.SOFT_SILK,
  "Wedding Silk": CategoryName.WEDDING_SILK
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
