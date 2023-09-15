// To parse this JSON data, do
//
//     final keepLogin = keepLoginFromJson(jsonString);

import 'dart:convert';

UserProfileModel keepLoginFromJson(String str) => UserProfileModel.fromJson(json.decode(str));



class UserProfileModel {
  Data? data;

  UserProfileModel({
    this.data,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) => UserProfileModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

}

class Data {
  List<UserProfile>? userProfile;

  Data({
    this.userProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userProfile: json["user_profile"] == null ? [] : List<UserProfile>.from(json["user_profile"]!.map((x) => UserProfile.fromJson(x))),
  );


}

class UserProfile {
  int? userId;
  String? userName;
  String? email;
  dynamic phone;
  dynamic doorNo;
  dynamic streetName;
  dynamic city;
  String? state;
  int? stateId;
  String? shortName;
  int? shippingCharge;
  int? codCharge;
  String? pincode;
  String? referralCode;
  int? totalPointsEarned;
  dynamic totalPointsReceived;
  String? couponName;
  String? couponCode;
  String? colorCode;
  dynamic userImage;

  UserProfile({
    this.userId,
    this.userName,
    this.email,
    this.phone,
    this.doorNo,
    this.streetName,
    this.city,
    this.state,
    this.stateId,
    this.shortName,
    this.shippingCharge,
    this.codCharge,
    this.pincode,
    this.referralCode,
    this.totalPointsEarned,
    this.totalPointsReceived,
    this.couponName,
    this.couponCode,
    this.colorCode,
    this.userImage,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    userId: json["user_id"],
    userName: json["user_name"],
    email: json["email"],
    phone: json["phone"],
    doorNo: json["door_no"],
    streetName: json["street_name"],
    city: json["city"],
    state: json["state"],
    stateId: json["state_id"],
    shortName: json["short_name"],
    shippingCharge: json["shipping_charge"],
    codCharge: json["cod_charge"],
    pincode: json["pincode"],
    referralCode: json["referral_code"],
    totalPointsEarned: json["total_points_earned"],
    totalPointsReceived: json["total_points_received"],
    couponName: json["coupon_name"],
    couponCode: json["coupon_code"],
    colorCode: json["color_code"],
    userImage: json["user_image"],
  );


}
