import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nithitex/features/categories/models/wish_list_model.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import '../../../utils/app_constants.dart';
import '../models/order_list_model.dart';


class OrderListCall{

  Future<OrderListModel> getData(link) async {
    String _url="${baseUrl}/api/$link";
    final response = await http.get(Uri.parse(_url),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
        }
    );
    print(response.statusCode);
      print("token {token[0]}");
    if (response.statusCode == 200) {
      var _data = OrderListModel.fromJson(json.decode(response.body));


      print(_data.data!.orders![0].orderId);
      return _data;
    } else {

      throw Exception('Failed to login.');
    }
  }}