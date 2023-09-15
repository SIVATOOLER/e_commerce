import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/register_model.dart';

Future<RegisterModel> registerUser(
    String name,
    String email,
    String phone,
    String password,

    ) async {
  final response =
  await http.post(Uri.parse('http://15.206.198.66/api/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode({
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      })


  );

  if (response.statusCode == 201 || response.statusCode == 200) {
print("jbjbjbj");
    return registerModelFromJson(response.body);
  } else {
  print(response.statusCode);
    throw Exception('Failed to connect.');
  }
}



