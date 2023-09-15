import 'dart:convert';

import 'package:nithitex/features/categories/models/product_detail_model.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';
import 'package:nithitex/features/categories/views/screens/product_detail_page.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';
import '../views/widgets/list_widget.dart';
import 'package:http/http.dart'as http;


class PostMethodCall{

  Future<ProductDetailModel> getData(link) async {
    String _url="${baseUrl}/api/product/detail/$link";



    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
        },
        body: json.encode({"user_id": "${SharedPrefs.getUserId}"}));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _data = ProductDetailModel.fromJson(json.decode(response.body));


      print(_data.data.product[0].isFavourite);
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}