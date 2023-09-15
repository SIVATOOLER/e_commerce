import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';
import '../views/widgets/list_widget.dart';


class AllProductApiServices{
  String _url="${baseUrl}/api/allproducts";

  Future<AllProductModel> getAllProductList(int homePageIndex) async {

    final favList=await WishListCall().getWishListCall();

    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: json.encode({"product_type": homePageIndex}));
    if (response.statusCode == 200) {
      var _data = AllProductModel.fromJson(json.decode(response.body));



      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}