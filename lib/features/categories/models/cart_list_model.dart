// To parse this JSON data, do
//
//     final cartListModel = cartListModelFromJson(jsonString);

import 'dart:convert';

CartListModel cartListModelFromJson(String str) => CartListModel.fromJson(json.decode(str));

String cartListModelToJson(CartListModel data) => json.encode(data.toJson());

class CartListModel {
  Data data;
  int quantity;
  int total;

  CartListModel({
    required this.data,
    required this.quantity,
    required this.total,
  });

  factory CartListModel.fromJson(Map<String, dynamic> json) => CartListModel(
    data: Data.fromJson(json["data"]),
    quantity: json["quantity"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "quantity": quantity,
    "total": total,
  };
}

class Data {
  List<Cart> cart;

  Data({
    required this.cart,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    cart: List<Cart>.from(json["cart"].map((x) => Cart.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cart": List<dynamic>.from(cart.map((x) => x.toJson())),
  };
}

class Cart {
  int cartId;
  int userId;
  int productId;
  String name;
  String qty;
  String productPrice;
  String productDiscount;
  String availableQuantity;
  String image;

  Cart({
    required this.cartId,
    required this.userId,
    required this.productId,
    required this.name,
    required this.qty,
    required this.productPrice,
    required this.productDiscount,
    required this.availableQuantity,
    required this.image,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
    cartId: json["cart_id"],
    userId: json["user_id"],
    productId: json["product_id"],
    name: json["name"],
    qty: json["qty"],
    productPrice: json["product_price"],
    productDiscount: json["product_discount"],
    availableQuantity: json["available_quantity"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "cart_id": cartId,
    "user_id": userId,
    "product_id": productId,
    "name": name,
    "qty": qty,
    "product_price": productPrice,
    "product_discount": productDiscount,
    "available_quantity": availableQuantity,
    "image": image,
  };
}
