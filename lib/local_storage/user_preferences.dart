import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop_app/modals/user_modal.dart';

class UserPreferences {
  static late SharedPreferences _sharedPreferences;

  static Future init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static UserModal currentUser = UserModal(
    userId: '7hHMIm7efIaUVqjXAMtAwua0JhL2',
    userPhone: 'NoUserPhone',
    userEmail: 'NoUserEmail',
    userName: 'NoUserName',
  );

  //static UserModal? currentUser;

  static String _userKey = 'currentUser';

  static Future setUser(UserModal? user) async {
    final json = user == null
        ? jsonEncode(currentUser.toJson())
        : jsonEncode(user.toJson());
    await _sharedPreferences.setString(_userKey, json);
  }

  static UserModal getUser() {
    final json = _sharedPreferences.getString(_userKey);
    return json == null ? currentUser : UserModal.fromJson(jsonDecode(json));
  }

  // static UserModal getUser() {
  //   final json = _sharedPreferences.getString(_userKey);
  //   return json == null ? currentUser : UserModal.fromJson(jsonDecode(json));
  // }

  static Future setDarkMode({required bool isDarkMode}) async {
    await _sharedPreferences.setBool('isDarkMode', isDarkMode);
  }

  static bool getDarkModeValue(){
    final isDarkMode = _sharedPreferences.getBool('isDarkMode');
    return isDarkMode == null ? false : isDarkMode;
  }
}
