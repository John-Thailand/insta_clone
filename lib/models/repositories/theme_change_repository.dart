import 'package:shared_preferences/shared_preferences.dart';

const PREF_KEY = "isDarkOn";

class ThemeChangeRepository {
  static bool isDarkOn = false;

  Future<void> setTheme(bool isDark) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(PREF_KEY, isDark);
    isDarkOn = isDark;
  }

  getIsDarkOn() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.getBool(PREF_KEY) ?? true;
  }
}
