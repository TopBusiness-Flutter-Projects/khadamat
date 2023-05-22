import 'dart:convert';


import '../utils/app_strings.dart';

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
}
