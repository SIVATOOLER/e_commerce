import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/app_constants.dart';
import '../../../utils/shared_prefs.dart';
import '../models/add_cart_list_model.dart';
import '../models/del_cart_List_item-model.dart';


class DelCartListCall{

  Future<DelCartListModel> getDelCartListCall(id) async {
    String _url="${baseUrl}/api/cart/delete/$id";
    final response = await http.get(Uri.parse(_url),
        headers: <String, String>{
          'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
     );
    print(response.statusCode);
    if (response.statusCode == 200) {
      var _data = DelCartListModel.fromJson(json.decode(response.body));


      print(_data.message);
      return _data;
    } else {
      throw Exception('Failed to login.');
    }
  }}