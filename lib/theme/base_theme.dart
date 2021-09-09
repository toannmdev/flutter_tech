import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toannm_test/configs/app_colors.dart';
import 'package:toannm_test/configs/app_str.dart';
import 'package:toannm_test/storages/hive_app.dart';

class ThemeService {
  const ThemeService._();

  static final ThemeService instance = const ThemeService._();

  ThemeMode get theme => _isDarkTheme() ? ThemeMode.dark : ThemeMode.light;

  bool _isDarkTheme() =>
      HiveApp.instance.hive.get(AppStr.keyIsDarkTheme, defaultValue: false);

  _saveThemeToBox(bool isDarkMode) =>
      HiveApp.instance.hive.put(AppStr.keyIsDarkTheme, isDarkMode);

  void switchTheme() {
    _saveThemeToBox(!_isDarkTheme());
    Get.changeTheme(getThemeApp());
  }

  /// [isDarkMode] hiện tại để 2 Theme dark và light
  ThemeData getThemeApp() {
    bool _isDarkMode = _isDarkTheme();
    ThemeData _base = _isDarkMode ? ThemeData.dark() : ThemeData.light();

    //Config theme
    TextTheme _buildTextTheme() {
      final TextTheme _textTheme = _base.textTheme;

      final Color _textColor = AppColors.instance.textColorTheme(_isDarkMode);
      final Color _subTextColor = AppColors.instance.subTextColor(_isDarkMode);

      return _base.textTheme.copyWith(
        // headline
        headline1: _textTheme.headline1!.copyWith(
            fontSize: 36, fontWeight: FontWeight.bold, color: _textColor),
        headline2: _textTheme.headline2!.copyWith(
            fontSize: 32, fontWeight: FontWeight.bold, color: _textColor),
        headline3: _textTheme.headline3!.copyWith(
            fontSize: 26, fontWeight: FontWeight.bold, color: _textColor),
        headline4: _textTheme.headline4!.copyWith(
            fontSize: 24, fontWeight: FontWeight.bold, color: _textColor),
        headline5:
            _textTheme.headline5!.copyWith(fontSize: 22, color: _textColor),
        headline6:
            _textTheme.headline6!.copyWith(fontSize: 20, color: _textColor),
        // subtitle
        subtitle1:
            _textTheme.subtitle1!.copyWith(fontSize: 14, color: _textColor),
        subtitle2:
            _textTheme.subtitle2!.copyWith(fontSize: 12, color: _subTextColor),
        // body
        bodyText1:
            _textTheme.bodyText1!.copyWith(fontSize: 16, color: _textColor),
        bodyText2:
            _textTheme.bodyText2!.copyWith(fontSize: 14, color: _subTextColor),
        caption: _textTheme.caption!.copyWith(fontSize: 12, color: _textColor),
        // button
        button: _textTheme.button!.copyWith(fontSize: 14, color: _textColor),
      );
    }

    IconThemeData _buildIconTheme() => _base.iconTheme.copyWith(
          color: _isDarkMode
              ? Colors.white
              : AppColors.instance.subTextColor(_isDarkMode),
          size: 20.0,
        );

    return _base.copyWith(
      // themes
      textTheme: _buildTextTheme(),
      iconTheme: _buildIconTheme(),

      // scaffoldBackgroundColor: AppColors.primaryColorTheme(isDarkMode),
      accentColor: Colors.orange,
    );
    // buttonColor: AppColors.buttonColor,
    // cardColor: isDarkMode ? AppColors.cardColor : Colors.pink[50],
    // secondaryHeaderColor: isDarkMode ? AppColors.buttonColor2 : Colors.grey,
    // backgroundColor: isDarkMode ? AppColors.backgroundColor : Colors.white,
    // dialogBackgroundColor: AppColors.darkPrimaryColor);
  }
}
