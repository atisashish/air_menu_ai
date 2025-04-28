import 'package:air_menu_ai_app/app/auth_screen/phone_number_screen.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final Future<SharedPreferences> prefsData =
      SharedPreferences.getInstance();

  static Future<void> setLogin(bool isLogin) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setBool("isLogin", isLogin);
  }

  static Future<bool> getLogin() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getBool("isLogin") ?? false;
  }

  static Future<void> setToken(String isToken) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("isToken", isToken);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("isToken") ?? '';
  }

  static Future<void> setId(String isId) async {
    final SharedPreferences prefs = await prefsData;
    await prefs.setString("isId", isId);
  }

  static Future<String> getId() async {
    final SharedPreferences prefs = await prefsData;
    return prefs.getString("isId") ?? '';
  }

  static prefsDataClear() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Get.offAll(const PhoneNumberScreen());
  }
}
