import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../utils/app_constants.dart';
import '../models/Profile_data_model.dart';

class ProfileDataApi{
  String _url="${baseUrl}/api/get/userprofile";
Future<UserProfileModel> keepLoginUser(token) async {
  var response = await http
      .get(Uri.parse(_url), headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    print(response.body);
    UserProfileModel data = UserProfileModel.fromJson(json.decode(response.body));

    return data;
  } else {
    throw Exception('Failed to get data');
  }
}}


