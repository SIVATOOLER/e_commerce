import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/features/categories/models/all_products_model.dart';
import 'package:nithitex/features/categories/repositories/wish_list_call.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../utils/app_constants.dart';
import '../views/widgets/list_widget.dart';


class SearchCall{

  Future<AllProductModel> getSearchProductList(String search) async {
    String _url="${baseUrl}/api/$search";


    final response = await http.post(Uri.parse(_url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
        },
        );
  //  print("okok${response.reasonPhrase}");
    if (response.statusCode == 200) {
      var _data = AllProductModel.fromJson(json.decode(response.body));


     // print("_data.data.productList[0].categoryName");
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}