import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toannm_test/configs/app_colors.dart';
import 'package:toannm_test/configs/app_dimens.dart';
import 'package:toannm_test/configs/app_str.dart';
import 'package:toannm_test/configs/app_style.dart';
import 'package:toannm_test/models/notify/notification_response.dart';
import 'package:toannm_test/widgets/utils_widget.dart';
import 'package:toannm_test/utils/date_utils.dart';

class NotificationItem extends StatelessWidget {
  final NotificationData item;

  const NotificationItem({Key? key, required this.item}) : super(key: key);

  final SizedBox _defaultSizedBox = const SizedBox(height: 4);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => InkWell(
        onTap: () => item.setIsRead(),
        child: Container(
          padding: const EdgeInsets.all(0),
          color: item.getBgColor(),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIcons(),
              _buildTexts(),
            ],
          ),
        ),
        _buildMoreIcon(),
      ],
    ).paddingAll(AppDimens.paddingDefault);
  }

  Widget _buildIcons() {
    Widget _buildImage() {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: item.image ?? "",
          width: AppDimens.notificationImageSize,
          height: AppDimens.notificationImageSize,
          placeholder: (context, url) => Container(
            color: Colors.grey[200],
            child: const CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
      );
    }

    Widget _buildIcon() {
      return Positioned(
        child: Material(
          clipBehavior: Clip.hardEdge,
          shape: const CircleBorder(side: BorderSide(color: Colors.white)),
          child: CachedNetworkImage(
            imageUrl: item.icon ?? "",
            width: AppDimens.notificationIconSize,
            height: AppDimens.notificationIconSize,
          ),
        ),
        bottom: 0,
        right: 0,
      );
    }

    return SizedBox(
      width: 60,
      height: 60,
      child: Stack(
        children: [
          _buildImage(),
          _buildIcon(),
        ],
      ),
    );
  }

  Widget _buildTexts() {
    Widget _buildTitleText() {
      final List<String> _splitTitles = (item.message?.text ?? "").split(" ");
      return RichText(
        text: TextSpan(
          children: _splitTitles
              .map((e) => TextSpan(
                  text: '$e ',
                  style: item.highlightChars.contains(e)
                      ? AppStyle.textBoldStyle
                      : AppStyle.textNormalStyle))
              .toList(),
        ),
      );
    }

    Widget _buildDateTimeText() {
      return Text(
        DateTimeUtils.convertDateToStringDefault(item.receivedAt ?? 0),
        style: AppStyle.textNormalStyle,
        maxLines: 1,
      );
    }

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitleText(),
          _defaultSizedBox,
          _buildDateTimeText(),
          _defaultSizedBox
        ],
      ).paddingOnly(left: AppDimens.paddingDefault),
    );
  }

  Widget _buildMoreIcon() {
    return InkWell(
      onTap: () => _showSnackBar(),
      child: UtilWidget.buildImageAsset(
        AppStr.iconMoreHozt,
        iconColor: AppColors.colorIcon,
      ),
    );
  }

  void _showSnackBar() {
    Get.showSnackbar(
      GetBar(
        backgroundColor: Colors.blue,
        messageText: Text(
          "You just clicked on more button",
          style: Get.textTheme.bodyText1,
        ),
        duration: Duration(seconds: 3),
        mainButton: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.close),
        ),
      ),
    );
  }
}
