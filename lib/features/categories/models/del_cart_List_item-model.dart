// To parse this JSON data, do
//
//     final delCartListModel = delCartListModelFromJson(jsonString);

import 'dart:convert';

DelCartListModel delCartListModelFromJson(String str) => DelCartListModel.fromJson(json.decode(str));

String delCartListModelToJson(DelCartListModel data) => json.encode(data.toJson());

class DelCartListModel {
  bool status;
  String message;

  DelCartListModel({
    required this.status,
    required this.message,
  });

  factory DelCartListModel.fromJson(Map<String, dynamic> json) => DelCartListModel(
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
  };
}
