import 'package:nithitex/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {

  static SharedPreferences? _sharedPrefs;
  static Future<void> initialize() async{
    if(_sharedPrefs != null) {
      return;
    } else {
      _sharedPrefs = await SharedPreferences.getInstance();
    }
  }

  Future<void> saveUserToken(String token) async{
    _sharedPrefs!.setString(AppConstants.tokenKey, token);
  }

 static String? get getUserToken => _sharedPrefs!.getString(AppConstants.tokenKey);
 static String? get getUserName => _sharedPrefs!.getString(AppConstants.userName);
 static String? get getUserId => _sharedPrefs!.getString(AppConstants.userId);
}