// To parse this JSON data, do
//
//     final addWishListModel = addWishListModelFromJson(jsonString);

import 'dart:convert';

AddWishListModel addWishListModelFromJson(String str) => AddWishListModel.fromJson(json.decode(str));


class AddWishListModel {
  bool status;
  String message;
  Data? data;

  AddWishListModel({
    required this.status,
    required this.message,
     this.data,
  });

  factory AddWishListModel.fromJson(Map<String, dynamic> json) => AddWishListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );


}

class Data {
  String productId;
  int userId;

  Data({
    required this.productId,
    required this.userId,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    productId: json["product_id"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "user_id": userId,
  };
}
