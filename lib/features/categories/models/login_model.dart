
import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? status;
  String? message;
  Data? data;

  LoginModel({
    this.status,
    this.message,
    this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  String? name;
  String? token;
  int? userroleId;
  String? phone;
  String? email;
  bool? isOtpVerified;

  Data({
    this.id,
    this.name,
    this.token,
    this.userroleId,
    this.phone,
    this.email,
    this.isOtpVerified,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    token: json["token"],
    userroleId: json["userrole_id"],
    phone: json["phone"],
    email: json["email"],
    isOtpVerified: json["IsOTPVerified"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "token": token,
    "userrole_id": userroleId,
    "phone": phone,
    "email": email,
    "IsOTPVerified": isOtpVerified,
  };
}
