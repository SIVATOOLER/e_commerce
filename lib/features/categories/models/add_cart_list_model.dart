// To parse this JSON data, do
//
//     final addCartListModel = addCartListModelFromJson(jsonString);

import 'dart:convert';

AddCartListModel addCartListModelFromJson(String str) => AddCartListModel.fromJson(json.decode(str));

String addCartListModelToJson(AddCartListModel data) => json.encode(data.toJson());

class AddCartListModel {
  bool? status;
  String? error;
  String? msg;

  AddCartListModel({
    this.status,
    this.error,
    this.msg,
  });

  factory AddCartListModel.fromJson(Map<String, dynamic> json) => AddCartListModel(
    status: json["status"],
    error: json["error"],
    msg: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "error": error,
    "message": msg,
  };
}
