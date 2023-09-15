import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/app_constants.dart';
import '../models/categories_model.dart';

class ApiServicesCatagories{
  String _url="${baseUrl}/api/categorylist";

  Future<Categories> categoryData() async {
    final response = await http.get(Uri.parse(_url));

    if (response.statusCode == 200) {
      var data = Categories.fromJson(json.decode(response.body));


      return data;
    } else {
      print(response.statusCode);
      throw Exception('Failed to login.');
    }
  }}