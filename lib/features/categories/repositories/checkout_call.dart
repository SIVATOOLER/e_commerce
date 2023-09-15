import 'dart:convert';

import 'package:nithitex/features/categories/models/checkout_model.dart';
import 'package:nithitex/features/categories/models/product_detail_model.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';
import 'package:http/http.dart'as http;


class CheckoutCall{

  Future<CheckoutModel> getData(
      link,doorno,streetAddress,
      cityName,stateName, name,
      email,phoneNo,pincode,alterNumber,total
      ) async {
    String _url="${baseUrl}/api/$link";



    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
        },
        body: json.encode({
          'door_no': doorno,
          'street_address': streetAddress,
          'city_name': cityName,
          'state_name': stateName,
          'name': name,
          'email': email,
          'phone': phoneNo,
          'pin_code': pincode,
          'alternative_number': alterNumber,
          'cart_true': '1',
          'shipping_charge':"500" ,
          'cart_subtotal': "500",
          'cart_total': total,
          'payment_type': 'COD',
          'coupon_code': '0',
          'coupon_discount':  '0',
          'referral_discount': '0',

        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _data = CheckoutModel.fromJson(json.decode(response.body));


      print(_data.message);
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}