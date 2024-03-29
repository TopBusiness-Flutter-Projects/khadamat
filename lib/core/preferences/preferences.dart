import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';

class Preferences {
  static final Preferences instance = Preferences._internal();

  Preferences._internal();

  factory Preferences() => instance;

  // Future<void> setFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setString('onBoarding', 'Done');
  // }

  // Future<String?> getFirstInstall() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   String? jsonData = prefs.getString('onBoarding');
  //   return jsonData;
  // }

  Future<void> setServiceId(int id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setInt("service_id", id);
    print("++++++__________________*************************///////////");
    print(await getServiceId());
  }

  Future<int?> getServiceId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getInt("service_id");
  }

  Future<void> clearServiceId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove("service_id");
  }

  Future<void> setUser(LoginModel loginModel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(
        'user', jsonEncode(LoginModel.fromJson(loginModel.toJson())));
    print(await getUserModel());
  }

  Future<void> clearShared() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }

  Future<LoginModel> getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonData = preferences.getString('user');
    LoginModel userModel;
    if (jsonData != null) {
      userModel = LoginModel.fromJson(jsonDecode(jsonData));
    } else {
      userModel = LoginModel();
    }
    return userModel;
  }
}
