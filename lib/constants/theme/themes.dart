import 'package:flutter/material.dart';
import 'package:padosee/constants/theme/theme_manager.dart';

const PRIMARY_COLOR = Color(0xFF1565C0);

const WHITE_COLOR = Color(0xFFFFFFFF);
const TEXT_COLOR = Color(0xFF000000);
const HINT_TEXT_COLOR = Color(0x60000000);
const GREY_COLOR = Color(0xFF9E9E9E);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: ThemeManager.BACKGROUND_COLOR,
  appBarTheme: const AppBarTheme(
    backgroundColor: WHITE_COLOR,
  ),
);

ThemeData dartTheme = ThemeData(
  brightness: Brightness.dark,
);

ThemeData appTheme = ThemeData(
  brightness: ThemeManager.BRIGHTNESS,
  backgroundColor: ThemeManager.BACKGROUND_COLOR,
);
