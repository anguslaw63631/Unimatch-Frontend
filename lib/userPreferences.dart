import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences preferences;
  static const KEY_BANID = 'banid';
  static const KEY_TUTORIAL = 'tutorial';
  static const KEY_LOCALE = 'locale';
  static const KEY_USERNAME = 'username';
  static const KEY_PWD = 'pwd';
  static const KEY_TOKEN = 'token';
  static const KEY_CHATSAFElY = 'chatsafely';

  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future setLocale(String locale) async {
    await preferences.setString(KEY_LOCALE, locale);
  }

  static String? getLocale() {
    return preferences.getString(KEY_LOCALE);
  }

  static Future setChatSafely(bool status) async {
    await preferences.setBool(KEY_CHATSAFElY, status);
  }

  static bool? getChatSafely() {
    return preferences.getBool(KEY_CHATSAFElY);
  }

  static Future setBanId(List<String> array) async {
    await preferences.setStringList(KEY_BANID, array);
  }

  static List<String>? getBanId() {
    return preferences.getStringList(KEY_BANID);
  }

  static Future setTutorial(bool status) async {
    await preferences.setBool(KEY_TUTORIAL, status);
  }

  static bool? getTutorial() {
    return preferences.getBool(KEY_TUTORIAL);
  }

  static Future setUsername(String username) async {
    await preferences.setString(KEY_USERNAME, username);
  }

  static String? getUsername() {
    return preferences.getString(KEY_USERNAME);
  }

  static Future setPwd(String pwd) async {
    await preferences.setString(KEY_PWD, pwd);
  }

  static String? getPwd() {
    return preferences.getString(KEY_PWD);
  }

  static Future setToken(String token) async {
    await preferences.setString(KEY_TOKEN, token);
  }

  static String? getToken() {
    return preferences.getString(KEY_TOKEN);
  }
}