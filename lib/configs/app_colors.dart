import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static final AppColors instance = const AppColors._();

  static const colorText = const Color(0xff1A1A1A);
  static const colorTextDate = const Color(0xff808080);
  static const colorIcon = const Color(0xff4D4D4D);

  static const bgNotiSelected = const Color(0xffECF7E7);

  static const bg = const Color(0xffE5E5E5);

  Color textColorTheme(bool isDarkMode) {
    return isDarkMode ? Color(0xffF0F0F0) : Color(0xff111111);
  }

  Color subTextColor(bool isDarkMode) {
    return isDarkMode ? Color(0xffD0D0D0) : Color(0xff3D3D3D);
  }
}
