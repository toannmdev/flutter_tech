import 'package:flutter/material.dart';
import 'package:toannm_test/feature/const/app_colors.dart';
import 'package:toannm_test/feature/const/app_const.dart';

/*
  Có thể sử dụng từ baseTheme, nhưng màn hình Thông báo, nếu text có thể scale theo settings hệ thống sẽ gây ra vỡ UI.
*/

class AppStyle {
  static const TextStyle textHeader1Style = const TextStyle(
    fontSize: 28,
    color: Colors.black,
    fontFamily: '${AppConst.assetFonts}/SF-Pro-Text-Bold.otf',
    fontWeight: FontWeight.bold,
  );
  static const TextStyle textNormalStyle = const TextStyle(
    fontSize: 14,
    color: AppColors.colorText,
    fontFamily: '${AppConst.assetFonts}/SF-Pro-Text-Regular.otf',
  );
  static const TextStyle textBoldStyle = const TextStyle(
    fontSize: 14,
    color: AppColors.colorText,
    fontFamily: '${AppConst.assetFonts}/SF-Pro-Text-Bold.otf',
    fontWeight: FontWeight.bold,
  );
}
