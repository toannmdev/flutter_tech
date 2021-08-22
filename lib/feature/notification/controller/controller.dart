import 'dart:async';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/feature/notification/model/response.dart';
import 'package:toannm_test/feature/notification/repository/repository.dart';

class NotificationController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final NotificationRepository repository = NotificationRepository();

  // for filtering Datum
  final List<Datum> _totalData = [];

  RxList<Datum> data = RxList();

  RxBool isSearching = false.obs;

  RxBool isLoading = true.obs;

  bool _isFirstPage() => true;

  final FocusNode searchFocus = FocusNode();

  late String filterText;

  @override
  void onInit() async {
    _getUserResponse();

    super.onInit();
  }

  void onRefresh() async {
    _getUserResponse();
  }

  Future<NotificationResponse> _getUserResponse() async {
    _onLoading();

    NotificationResponse notificationResponse =
        await repository.getNotifications();

    _onLoadingSuccess();

    _handleData();

    _handleRefreshController();

    _handleResponse(notificationResponse);

    return notificationResponse;
  }

  void _onLoading() {
    isLoading.value = true;
  }

  void _onLoadingSuccess() {
    isLoading.value = false;
  }

  void _handleRefreshController() {
    // no loadMore.
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void _handleData() {
    if (_isFirstPage()) {
      _totalData.clear();
      data.clear();
    }
  }

  void _handleResponse(NotificationResponse notificationResponse) {
    _totalData.addAll(notificationResponse.data ?? []);
    data.addAll(_totalData);
  }

  void onFilterData(String _filterText) {
    filterText = removeDiacritics(_filterText.toLowerCase());

    data.clear();
    if (filterText.isEmpty) return data.addAll(_totalData);

    data.value = _totalData
        .where((item) =>
            removeDiacritics(item.message?.text?.toLowerCase() ?? "")
                .contains(filterText))
        .toList();
  }
}
