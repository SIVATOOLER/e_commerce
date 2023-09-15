// To parse this JSON data, do
//
//     final orderDetailModel = orderDetailModelFromJson(jsonString);

import 'dart:convert';

OrderDetailModel orderDetailModelFromJson(String str) => OrderDetailModel.fromJson(json.decode(str));

String orderDetailModelToJson(OrderDetailModel data) => json.encode(data.toJson());

class OrderDetailModel {
  Data? data;

  OrderDetailModel({
    this.data,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) => OrderDetailModel(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
  };
}

class Data {
  List<Order>? orders;
  List<OrdersDetail>? ordersDetail;

  Data({
    this.orders,
    this.ordersDetail,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
    ordersDetail: json["orders_detail"] == null ? [] : List<OrdersDetail>.from(json["orders_detail"]!.map((x) => OrdersDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
    "orders_detail": ordersDetail == null ? [] : List<dynamic>.from(ordersDetail!.map((x) => x.toJson())),
  };
}

class Order {
  String? orderDate;
  String? cancelDate;
  String? returnDate;
  String? orderId;
  String? orderNumber;
  String? invoiceNumber;
  String? subTotal;
  String? shippingCharge;
  int? marginAmount;
  int? couponDiscount;
  int? referralDiscount;
  String? amount;
  String? paymentType;
  String? paymentStatus;
  String? status;
  String? name;
  String? phone;
  String? doorNo;
  String? streetAddress;
  String? cityName;
  String? stateName;
  dynamic stateId;
  String? pinCode;
  String? isReturned;
  dynamic returnReason;
  String? isCancelled;
  String? transactionId;
  int? totQty;
  int? qty;
  String? alternativeNumber;

  Order({
    this.orderDate,
    this.cancelDate,
    this.returnDate,
    this.orderId,
    this.orderNumber,
    this.invoiceNumber,
    this.subTotal,
    this.shippingCharge,
    this.marginAmount,
    this.couponDiscount,
    this.referralDiscount,
    this.amount,
    this.paymentType,
    this.paymentStatus,
    this.status,
    this.name,
    this.phone,
    this.doorNo,
    this.streetAddress,
    this.cityName,
    this.stateName,
    this.stateId,
    this.pinCode,
    this.isReturned,
    this.returnReason,
    this.isCancelled,
    this.transactionId,
    this.qty,
    this.totQty,
    this.alternativeNumber,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    orderDate: json["order_date"],
    cancelDate: json["cancel_date"],
    returnDate: json["return_date"],
    orderId: json["order_id"],
    orderNumber: json["order_number"],
    invoiceNumber: json["invoice_number"],
    subTotal: json["sub_total"],
    shippingCharge: json["shipping_charge"],
    marginAmount: json["margin_amount"],
    couponDiscount: json["coupon_discount"],
    referralDiscount: json["referral_discount"],
    amount: json["amount"],
    paymentType: json["payment_type"],
    paymentStatus: json["payment_status"],
    status: json["status"],
    name: json["name"],
    phone: json["phone"],
    doorNo: json["door_no"],
    streetAddress: json["street_address"],
    cityName: json["city_name"],
    stateName: json["state_name"],
    stateId: json["state_id"],
    pinCode: json["pin_code"],
    isReturned: json["is_returned"],
    returnReason: json["return_reason"],
    isCancelled: json["is_cancelled"],
    transactionId: json["transaction_id"],
    totQty: json["tot_Qty"],
    qty: json["qty"],
    alternativeNumber: json["alternative_number"],
  );

  Map<String, dynamic> toJson() => {
    "order_date": orderDate,
    "cancel_date": cancelDate,
    "return_date": returnDate,
    "order_id": orderId,
    "order_number": orderNumber,
    "invoice_number": invoiceNumber,
    "sub_total": subTotal,
    "shipping_charge": shippingCharge,
    "margin_amount": marginAmount,
    "coupon_discount": couponDiscount,
    "referral_discount": referralDiscount,
    "amount": amount,
    "payment_type": paymentType,
    "payment_status": paymentStatus,
    "status": status,
    "name": name,
    "phone": phone,
    "door_no": doorNo,
    "street_address": streetAddress,
    "city_name": cityName,
    "state_name": stateName,
    "state_id": stateId,
    "pin_code": pinCode,
    "is_returned": isReturned,
    "return_reason": returnReason,
    "is_cancelled": isCancelled,
    "transaction_id": transactionId,
    "tot_Qty": totQty,
    "alternative_number": alternativeNumber,
  };
}

class OrdersDetail {
  int? productId;
  String? qty;
  String? productName;
  int? productPrice;
  String? productImage;

  OrdersDetail({
    this.productId,
    this.qty,
    this.productName,
    this.productPrice,
    this.productImage,
  });

  factory OrdersDetail.fromJson(Map<String, dynamic> json) => OrdersDetail(
    productId: json["product_id"],
    qty: json["qty"],
    productName: json["product_name"],
    productPrice: json["product_price"],
    productImage: json["product_image"],
  );

  Map<String, dynamic> toJson() => {
    "product_id": productId,
    "qty": qty,
    "product_name": productName,
    "product_price": productPrice,
    "product_image": productImage,
  };
}
