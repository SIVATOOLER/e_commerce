import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/features/categories/models/wish_list_model.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';


class WishListCall{
  String _url="${baseUrl}/api/wishlist/product";

  Future<WishListModel> getWishListCall() async {
    final response = await http.get(Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
        }
        );
    print(response.statusCode);
  //  print("token ${token[0]}");
    if (response.statusCode == 200) {
      var _data = WishListModel.fromJson(json.decode(response.body));


      print(_data.data.productList[0].productId);
      return _data;
    } else {

      throw Exception('Failed to login.');
    }
  }}