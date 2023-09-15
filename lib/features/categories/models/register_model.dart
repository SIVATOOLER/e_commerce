// To parse this JSON data, do
//
//     final registerModel = registerModelFromJson(jsonString);

import 'dart:convert';

RegisterModel registerModelFromJson(String str) => RegisterModel.fromJson(json.decode(str));


class RegisterModel {
  bool status;
  String message;
  int userId;
  String phone;
  String referralCode;

  RegisterModel({
    required this.status,
    required this.message,
    required this.userId,
    required this.phone,
    required this.referralCode,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    status: json["status"],
    message: json["message"],
    userId: json["user_id"],
    phone: json["phone"],
    referralCode: json["referral_code"],
  );

}
