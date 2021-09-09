import 'dart:async';

import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toannm_test/base/controllers/base_list_controller.dart';
import 'package:toannm_test/models/notify/notification_response.dart';
import 'package:toannm_test/screens/notification/repository/repository.dart';
import 'package:toannm_test/base/widget_actions/list_actions.dart';

class NotificationController
    extends BaseListController<NotificationResponse, NotificationData>
    implements ListAction<NotificationResponse> {
  final NotificationRepository _repository = NotificationRepository();

  // for filtering Datum
  final List<NotificationData> _totalData = [];

  RxBool isSearching = false.obs;

  RxBool isLoading = true.obs;

  final FocusNode searchFocus = FocusNode();

  final TextEditingController searchEdittingController =
      TextEditingController();

  late String filterText;

  @override
  Future<NotificationResponse> fetchData() => _repository.getNotifications();

  @override
  void onInit() {
    loadData();
    super.onInit();
  }

  @override
  void onLoading() {
    isLoading.value = true;
  }

  @override
  void onLoadingSuccess() {
    isLoading.value = false;
  }

  @override
  void clearDataIfNeeded() {
    if (isFirstPage()) _totalData.clear();
    super.clearDataIfNeeded();
  }

  @override
  void handleResponse(NotificationResponse response) {
    _totalData.addAll(response.data ?? []);
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

  void clearFilter() {
    filterText = '';
    searchEdittingController.text = '';
    onRefreshData();
  }
}
