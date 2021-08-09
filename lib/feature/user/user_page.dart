import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/feature/base/base_theme.dart';
import 'package:toannm_test/feature/user/controller/controller.dart';
import 'package:toannm_test/feature/user/model/response.dart';

class UserPage extends GetView {
  @override
  UserController get controller => Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToanNM 's test"),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => themeService.switchTheme(),
            child: Text(
              "${themeService.isDarkThemeFromBox() ? 'Light Theme' : 'Dark Theme'}",
              style: Get.textTheme.bodyText2!
                  .copyWith(color: Get.theme.buttonColor),
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Obx(
      () => controller.error.isNotEmpty
          ? Column(
              children: [
                Flexible(
                    child: SingleChildScrollView(
                        child: Text(controller.error.value))),
                TextButton(
                    onPressed: controller.onRefresh, child: Text('Retry')),
              ],
            ).paddingAll(16)
          : controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : SmartRefresher(
                  controller: controller.refreshController,
                  onLoading: () => controller.onLoadMore(),
                  onRefresh: () => controller.onRefresh(),
                  enablePullDown: true,
                  enablePullUp: true,
                  child: CustomScrollView(
                    slivers: [
                      SliverStickyHeader(
                        overlapsContent: false,
                        sticky: true,
                        header: _buildHeaderList(),
                        sliver: _buildUserContentList(),
                      )
                    ],
                  ),
                ),
    );
  }

  Widget _buildHeaderList() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      color: Get.theme.scaffoldBackgroundColor,
      child: Text('Total: ${controller.data.length} records'),
    );
  }

  Widget _buildUserContentList() {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
      (context, index) => Column(
        children: _buildUserContentItems(index),
      ),
      childCount: controller.data.length,
    ));
  }

  List<Widget> _buildUserContentItems(int index) {
    final Datum _item = controller.data[index];

    return [
      ListTile(
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: _item.avatar ?? "",
              width: 40,
              height: 40,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text(
            "${_item.firstName} ${_item.lastName}",
            style: Get.textTheme.headline6,
          ),
          subtitle: Text(
            "${_item.email}",
            style: Get.textTheme.bodyText2,
          )),
      if (index < controller.data.length - 1) Divider()
    ];
  }
}
