import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/features/categories/models/add_wish-list.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';


class AddWishListCall{
  String _url="${baseUrl}/api/wishlist/add";

  Future<AddWishListModel> getAddWishListCall( productId) async {
    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
        'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"product_id":productId }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _data = AddWishListModel.fromJson(json.decode(response.body));


      print(_data.message);
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}