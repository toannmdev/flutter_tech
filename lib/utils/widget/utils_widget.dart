import 'package:flutter/widgets.dart';
import 'package:toannm_test/feature/const/app_colors.dart';
import 'package:toannm_test/feature/const/app_dimens.dart';

class UtilWidget {
  static Widget buildImageAsset(String assetImg,
      {Color iconColor = AppColors.colorText}) {
    return Image.asset(
      assetImg,
      width: AppDimens.notificationIconSize,
      height: AppDimens.notificationIconSize,
      color: iconColor,
    );
  }
}
