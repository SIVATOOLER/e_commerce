// To parse this JSON data, do
//
//     final checkoutModel = checkoutModelFromJson(jsonString);

import 'dart:convert';

CheckoutModel checkoutModelFromJson(String str) => CheckoutModel.fromJson(json.decode(str));

String checkoutModelToJson(CheckoutModel data) => json.encode(data.toJson());

class CheckoutModel {
  bool? status;
  int? orderId;
  String? message;
  Error? error;

  CheckoutModel({
    this.status,
    this.orderId,
    this.message,
    this.error,
  });

  factory CheckoutModel.fromJson(Map<String, dynamic> json) => CheckoutModel(
    status: json["status"],
    orderId: json["order_id"],
    message: json["message"],
    error: json["error"] == null ? null : Error.fromJson(json["error"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "error": error?.toJson(),
  };
}

class Error {
  List<dynamic>? errorInfo;

  Error({
    this.errorInfo,
  });

  factory Error.fromJson(Map<String, dynamic> json) => Error(
    errorInfo: json["errorInfo"] == null ? [] : List<dynamic>.from(json["errorInfo"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "errorInfo": errorInfo == null ? [] : List<dynamic>.from(errorInfo!.map((x) => x)),
  };
}
