import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunctions {

  static String userLogadoKey = "USERLOGADOKEY";

  static salvarUserLogado({@required bool estaLogado}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(userLogadoKey, estaLogado);
  }

  static Future<bool> getUserLogado() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(userLogadoKey);
  }
}