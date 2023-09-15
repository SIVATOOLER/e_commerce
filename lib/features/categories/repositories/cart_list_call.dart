import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';
import '../models/cart_list_model.dart';


class CartListCall{
  String _url="${baseUrl}/api/get/cartlist";

  Future<CartListModel> getCartListCall() async {
    final response = await http.get(Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
        }
    );
    if (response.statusCode == 200) {
      var _data = CartListModel.fromJson(json.decode(response.body));



      return _data;
    } else {

      throw Exception('Failed to login.');
    }
  }}