import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../utils/app_constants.dart';
import '../models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
final userProvider= Provider<ApiServices>((ref)=>ApiServices());

class ApiServices{
  String _url="${baseUrl}/api/login";

Future<LoginModel> loginUser(String username, String password) async {
  final response = await http.post(Uri.parse(_url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({'username': username, 'password': password}));
  print(response.statusCode);
  if (response.statusCode == 200) {
    var _data = LoginModel.fromJson(json.decode(response.body));
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', _data.data!.token.toString());
    await prefs.setString('userName', _data.data!.name.toString());
    await prefs.setString('userId', _data.data!.id.toString());
    print(prefs.get("userId"));
    return _data;
  } else {
    throw Exception();

  }
}}