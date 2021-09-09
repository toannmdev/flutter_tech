import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/configs/app_colors.dart';
import 'package:toannm_test/configs/app_dimens.dart';
import 'package:toannm_test/configs/app_str.dart';
import 'package:toannm_test/configs/app_style.dart';
import 'package:toannm_test/screens/notification/controllers/controller.dart';
import 'package:toannm_test/screens/notification/widgets/notification_item.dart';
import 'package:toannm_test/theme/base_theme.dart';
import 'package:toannm_test/widgets/utils_widget.dart';

class NotificationPage extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: AppColors.bg,
        appBar: !controller.isSearching.value
            ? _buildAppBar()
            : _buildSearchAppBar(),
        body: _buildBody(),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white, elevation: 0,
      centerTitle: false,
      // TODO (toannm) translate string
      title: InkWell(
          onTap: () => ThemeService.instance.switchTheme(),
          child: Text("Thông báo", style: Get.textTheme.headline3!)),
      actions: [
        TextButton(
          onPressed: () {
            controller.isSearching.toggle();
            controller.searchFocus.requestFocus();
          },
          child: UtilWidget.buildImageAsset(AppStr.iconSearch),
        ),
      ],
    );
  }

  AppBar _buildSearchAppBar() {
    Widget _buildIconClose() {
      return InkWell(
        onTap: () => controller.isSearching.toggle(),
        child: UtilWidget.buildImageAsset(
          AppStr.iconClose,
          iconColor: AppColors.colorIcon,
        ),
      );
    }

    Widget _buildInputSearch() {
      return Expanded(
        child: CupertinoSearchTextField(
          controller: controller.searchEdittingController,
          prefixInsets: const EdgeInsetsDirectional.fromSTEB(6, 0, 14, 4),
          onChanged: (filterText) => controller.onFilterData(filterText),
          focusNode: controller.searchFocus,
        ),
      );
    }

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildIconClose(),
          const SizedBox(width: AppDimens.paddingDefault),
          _buildInputSearch(),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return controller.isLoading.value
        ? Center(child: const CircularProgressIndicator())
        : controller.data.length > 0
            ? SmartRefresher(
                controller: controller.refreshController,
                onRefresh: () => controller.onRefreshData(),
                enablePullDown: true,
                child: ListView.builder(
                  itemBuilder: (context, index) =>
                      NotificationItem(item: controller.data[index]),
                  itemCount: controller.data.length,
                ),
              )
            : _buildError();
  }

  Widget _buildError() {
    Widget _buildErrorContent() {
      return RichText(
        text: TextSpan(
          children: [
            const TextSpan(
                text: "No data when searching by: ",
                style: AppStyle.textNormalStyle),
            TextSpan(
                text: "'${controller.filterText}'",
                style: AppStyle.textBoldStyle),
          ],
        ),
        textAlign: TextAlign.center,
      );
    }

    Widget _buildErrorAction() {
      return TextButton(
        onPressed: () => controller.clearFilter(),
        child: const Text('Clear Filter'),
      );
    }

    // TODO (toannm): translate string
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildErrorContent(),
          _buildErrorAction(),
        ],
      ),
    );
  }
}

class TestWidget extends StatelessWidget {
  const TestWidget();
  @override
  Widget build(BuildContext context) {
    return Text('Text');
  }
}
