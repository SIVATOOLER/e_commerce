import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart'as http;
import 'package:image_picker/image_picker.dart';
import 'package:nithitex/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/app_constants.dart';




ploader(ImageSource) async {
  String _url="${baseUrl}/api//user/profile/update";
  ImagePicker imagePicker = ImagePicker();
  var _image;
  var source = ImageSource;
  XFile? image = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front);

  _image = File(image!.path);
  print(_image);


  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
  };
  var request =await http.MultipartRequest('POST',
      Uri.parse(_url))
    ..fields.addAll({
      'name': '',
      'phone': 'phone',

      'pin_code': 'pincode',
      'bank_name': '',
      'bank_account_name': '',
      'bank_account_number': '',
      'bank_ifsc': '',
      'street_address': '2md',
      'city_name': 'city',
      'state_name': 'state',
      'door_no': ''
    })

    ..headers.addAll(headers)
    ..files.add(await http.MultipartFile.fromPath('profile_photo_path', image.path));
  http.StreamedResponse response = await request.send();


  if (response.statusCode == 201|| response.statusCode==200) {
    print(await response.stream.bytesToString());
    return true;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);

    return false;
  }
}

class DataUploader{
  DataUploader({ this.name,this.phone,this.pincode,
    this.doorNo,this.city,this.state,this.stateId,this.street
  });

final name;
final phone;
final pincode;
final doorNo;
final city;
final state;
final stateId;
final street;


dataUploader() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  Object? token = prefs.get("token");


  Map<String, String> headers = {
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest(
      'POST', Uri.parse("http://15.206.198.66/api/user/profile/update"))
    ..fields.addAll({
      'name': name,
      'phone': phone,

      'pin_code': pincode,
      'bank_name': '',
      'bank_account_name': '',
      'bank_account_number': '',
      'bank_ifsc': '',
      'street_address': '2md',
      'city_name': city,
      'state_name': state,
      'door_no': doorNo
    })

    ..headers.addAll(headers)
  ;
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200  ||response.statusCode == 201) {
    print(await response.stream.bytesToString());
    print("ssssss");
    return true;
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    print("fffffffff");
    return false;
  }
}}


uploader(imageSource) async {

  ImagePicker imagePicker = ImagePicker();

  var source = imageSource;
  XFile? image = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
      preferredCameraDevice: CameraDevice.front);

 var _image = File(image!.path);

var headers = {
  'Authorization': 'Bearer ${SharedPrefs.getUserToken}',
};
var request = http.MultipartRequest(
    'POST', Uri.parse('http://15.206.198.66/api/user/profile/update'));
request.fields.addAll;
  request.fields.addAll({
    'name': 'sam',
    'phone': '',
    'shop_name': '',
    'pin_code': '111115',
    'bank_name': '',
    'bank_account_name': '',
    'bank_account_number': '',
    'bank_ifsc': '',
    'street_address': '',
    'city_name': '',
    'state_name': 'Tn',
    'door_no': ''
  });
request.files.add(await http.MultipartFile.fromPath('profile_photo_path',  image.path));
request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
print(await response.stream.bytesToString());
}
else {
print(response.reasonPhrase);
}
}