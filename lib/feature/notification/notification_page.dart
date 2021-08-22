import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/feature/const/app_colors.dart';
import 'package:toannm_test/feature/const/app_dimens.dart';
import 'package:toannm_test/feature/const/app_str.dart';
import 'package:toannm_test/feature/const/app_style.dart';
import 'package:toannm_test/feature/notification/widgets/item_widget.dart';
import 'package:toannm_test/utils/widget/utils_widget.dart';
import 'controller/controller.dart';

class NotificationPage extends GetView {
  @override
  NotificationController get controller => Get.put(NotificationController());

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
      title: const Text("Thông báo", style: AppStyle.textHeader1Style),
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
                onRefresh: () => controller.onRefresh(),
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
    // TODO (toannm): translate string
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "No data when searching by: ",
                    style: AppStyle.textNormalStyle),
                TextSpan(
                    text: "'${controller.filterText}'",
                    style: AppStyle.textBoldStyle),
              ],
            ),
            textAlign: TextAlign.center,
          ),
          TextButton(
            onPressed: () {
              controller.filterText = '';
              controller.onRefresh();
            },
            child: Text('Clear Filter'),
          ),
        ],
      ),
    );
  }
}
