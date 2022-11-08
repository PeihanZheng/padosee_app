import 'package:flutter/material.dart';
import 'package:padosee/constants/theme/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager with ChangeNotifier {
  static ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  set themeChange(ThemeMode mode) {
    _themeMode = mode;
    notifyListeners();
  }

  toggleTheme(bool isDark) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool("darkMode", isDark);
    notifyListeners();
  }

  static Color get BACKGROUND_COLOR => _themeMode == ThemeMode.light ? const Color(0xFFedf6fc) : const Color(0xff000e1e);

  static Brightness get BRIGHTNESS => _themeMode == ThemeMode.light ? Brightness.light : Brightness.dark;

  static Color get MENU_COLOR => _themeMode == ThemeMode.light ? primarycolor : const Color(0xFFFFFFFF).withOpacity(.9);

  static Color get APP_TITLE_COLOR => _themeMode == ThemeMode.light ? textcolor : const Color(0xFFFFFFFF).withOpacity(.9);

  static Color get TITLE_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF000000) : const Color(0xFFFFFFFF).withOpacity(.9);

  static Color get APP_TEXT_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF000000) : const Color(0xFFFFFFFF).withOpacity(.8);

  static Color get APP_TEXT_COLOR2 => _themeMode == ThemeMode.light ? primarycolor : const Color(0xFFFFFFFF).withOpacity(.8);

  static Color get CARD_COLOR => _themeMode == ThemeMode.light ? const Color(0xFFedf6fc) : primarycolor;

  static Color get CARD_COLOR2 => _themeMode == ThemeMode.light ? const Color(0xFFedf6fc) : primarycolor;

  static Color get BOX_SHADOW_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF9E9E9E).withOpacity(0.3) : Colors.transparent;

  static Color get TRANSPARENT_IMG_COLOR =>
      _themeMode == ThemeMode.light ? const Color(0xFF1565C0).withOpacity(0.3) : const Color(0xFFFFFFFF).withOpacity(.3);

  static Color get DRAWER_GREY_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF9E9E9E) : const Color(0xFFFFFFFF).withOpacity(.4);

  static Color get INPUT_LABEL_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF000000) : const Color(0xFFFFFFFF).withOpacity(.6);

  static Color get BLUE_BORDER_COLOR => _themeMode == ThemeMode.light ? const Color(0xFFFFFFFF) : primarycolor;

  static Color get PROFILE_SHADOW_COLOR => _themeMode == ThemeMode.light ? primarycolor.withOpacity(.25) : const Color(0xFFFFFFFF).withOpacity(.25);

  static Color get CAMERA_SHOW_COLOR => _themeMode == ThemeMode.light ? const Color(0x1F000000) : const Color(0xFFFFFFFF).withOpacity(.10);

  static Color get APP_HINT_TEXT_COLOR => _themeMode == ThemeMode.light ? const Color(0x60000000) : const Color(0xFFFFFFFF).withOpacity(.2);

  static Color get CURSOR_COLOR => _themeMode == ThemeMode.light ? const Color(0xFF000000) : primarycolor;

  static Color get DIVIDER_COLOR => _themeMode == ThemeMode.light ? primarycolor.withOpacity(.2) : const Color(0xFFFFFFFF).withOpacity(.2);

  static Color get SUBTITLE_COLOR => _themeMode == ThemeMode.light ? textcolor.withOpacity(.5) : const Color(0xFFFFFFFF).withOpacity(.4);

  static Color get INPUT_FILLED_COLOR =>
      _themeMode == ThemeMode.light ? const Color(0xFF9E9E9E).withOpacity(0.15) : const Color(0xFF9E9E9E).withOpacity(0.15);
}
