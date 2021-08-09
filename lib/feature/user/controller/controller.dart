import 'dart:async';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/feature/user/model/response.dart';
import 'package:toannm_test/feature/user/repository/repository.dart';

class UserController extends GetxController {
  final RefreshController refreshController = RefreshController();
  final UserRepository repository = UserRepository(Get.find<Dio>());

  int pageNumber = 1;

  late UserResponse _userResponse;

  RxList data = [].obs;

  RxBool isLoading = true.obs;

  RxString error = ''.obs;

  @override
  void onInit() async {
    _getUserResponse();

    super.onInit();
  }

  void onRefresh() async {
    pageNumber = 1;
    _getUserResponse();
  }

  void onLoadMore() async {
    if (!_isEndOfPages()) {
      pageNumber++;
      _getUserResponse();
    }
  }

  Future<UserResponse> _getUserResponse() async {
    _onLoading();
    _userResponse = await repository.getUsers(pageNumber).catchError((e) {
      if (_isFirstPage()) error.value = e.toString();
    });

    _onLoadingSuccess();
    if (_isFirstPage()) data.clear();

    if (_userResponse.data != null) data.addAll(_userResponse.data!);

    _handleRefreshController();

    return _userResponse;
  }

  void _onLoading() {
    error.value = '';
    isLoading.value = true;
  }

  void _onLoadingSuccess() {
    isLoading.value = false;
  }

  void _handleRefreshController() {
    if (_isEndOfPages()) {
      refreshController.loadNoData();
    } else {
      refreshController.refreshCompleted();
      refreshController.loadComplete();
    }
  }

  bool _isFirstPage() => pageNumber <= 1;

  bool _isEndOfPages() => pageNumber >= (_userResponse.totalPages ?? 0);
}
