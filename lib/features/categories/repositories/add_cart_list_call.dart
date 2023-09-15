import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';
import '../models/add_cart_list_model.dart';


class AddCartListCall{


  Future<AddCartListModel> getAddCartListCall( id,qty) async {
    String _url="${baseUrl}/api/cart/$id";
    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"qty":qty }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _data = AddCartListModel.fromJson(json.decode(response.body));


      print(_data.error);
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}