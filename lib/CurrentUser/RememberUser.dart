import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tosepatu/Model/userModel.dart';

class RememberUser {
  storeUser(userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', userInfo);
  }

  static Future<User> readUser() async {
    User currentUserInfo;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String userInfo = preferences.getString('user');
    if (userInfo != null) {
      Map<String, dynamic> userDataMap = jsonDecode(userInfo);
      currentUserInfo = User.fromJson(userDataMap);
    }
    return currentUserInfo;
  }

  static Future<void> removeUserSessions() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('user');
    preferences.clear();
    preferences.commit();
  }
}
