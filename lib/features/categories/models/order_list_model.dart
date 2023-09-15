// To parse this JSON data, do
//
//     final orderListModel = orderListModelFromJson(jsonString);

import 'dart:convert';

OrderListModel orderListModelFromJson(String str) => OrderListModel.fromJson(json.decode(str));

String orderListModelToJson(OrderListModel data) => json.encode(data.toJson());

class OrderListModel {
  Data? data;

  OrderListModel({
    this.data,
  });

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<Order>? orders;

  Data({
    this.orders,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  int? orderId;
  String? orderNumber;
  int? qty;
  String? orderDate;
  String? cancelDate;
  String? returnDate;
  String? subTotal;
  String? shippingCharge;
  String? paymentType;
  String? paymentStatus;
  String? status;
  String? total;
  String? isReturned;
  String? isCancelled;
  int? marginAmount;

  Order({
    this.orderId,
    this.orderNumber,
    this.qty,
    this.orderDate,
    this.cancelDate,
    this.returnDate,
    this.subTotal,
    this.shippingCharge,
    this.paymentType,
    this.paymentStatus,
    this.status,
    this.total,
    this.isReturned,
    this.isCancelled,
    this.marginAmount,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderId: json["order_id"],
    orderNumber: json["order_number"],
    qty: json["qty"],
    orderDate: json["order_date"],
    cancelDate: json["cancel_date"],
    returnDate: json["return_date"],
    subTotal: json["sub_total"],
    shippingCharge: json["shipping_charge"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    total: json["total"],
    isReturned: json["is_returned"],
    isCancelled: json["is_cancelled"],
    marginAmount: json["margin_amount"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "order_number": orderNumber,
    "qty": qty,
    "order_date": orderDate,
    "cancel_date": cancelDate,
    "return_date": returnDate,
    "sub_total": subTotal,
    "shipping_charge": shippingCharge,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "status": status,
    "total": total,
    "is_returned": isReturned,
    "is_cancelled": isCancelled,
    "margin_amount": marginAmount,
  };
}
