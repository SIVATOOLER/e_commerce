// To parse this JSON data, do
//
//     final wishListModel = wishListModelFromJson(jsonString);

import 'dart:convert';

WishListModel wishListModelFromJson(String str) => WishListModel.fromJson(json.decode(str));

String wishListModelToJson(WishListModel data) => json.encode(data.toJson());

class WishListModel {
  Data data;

  WishListModel({
    required this.data,
  });

  factory WishListModel.fromJson(Map<String, dynamic> json) => WishListModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
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
  int isFavourite;

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
