import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

final ThemeService themeService = ThemeService();

class ThemeService {
  final GetStorage _getStorage = GetStorage();
  static const String keyIsDarkTheme = "isDarkTheme";

  /// Get isDarkMode info from local storage and return ThemeMode
  ThemeMode get theme =>
      isDarkThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  /// Load isDArkMode from local storage and if it's empty, returns false (that means default theme is light)
  bool isDarkThemeFromBox() => _getStorage.read(keyIsDarkTheme) ?? false;

  /// Save isDarkMode to local storage
  _saveThemeToBox(bool isDarkMode) =>
      _getStorage.write(keyIsDarkTheme, isDarkMode);

  /// Switch theme and save to local storage
  void switchTheme() {
    Get.changeThemeMode(
        isDarkThemeFromBox() ? ThemeMode.dark : ThemeMode.light);
    _saveThemeToBox(!isDarkThemeFromBox());
  }
}
