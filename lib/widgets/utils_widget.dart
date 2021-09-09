import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:toannm_test/configs/app_colors.dart';
import 'package:toannm_test/configs/app_dimens.dart';

class UtilWidget {
  static Widget buildImageAsset(String assetImg,
      {Color iconColor = AppColors.colorText}) {
    return SvgPicture.asset(
      assetImg,
      color: iconColor,
      width: AppDimens.notificationIconSize,
      height: AppDimens.notificationIconSize,
    );
  }
}
