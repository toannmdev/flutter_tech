import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toannm_test/feature/widget_actions/list_actions.dart';

/// [R] : response
/// [T] : data
abstract class BaseListController<R, T> extends GetxController
    implements ListAction<R> {
  final RefreshController refreshController = RefreshController();

  RxList<T> data = RxList();

  /// fetch data from repository
  Future<R> fetchData();

  /// [onLoading] handle loading state
  /// [onLoadingSuccess] turn off loading, handele success or error response
  /// [clearDataIfNeeded] handle data before handle response,
  /// such as clear old data when refresh data
  /// [handleRefreshController] handle [refreshController] such as loadCompleted
  /// [handleResponse] handle response [R] before done future
  Future<R> loadData() async {
    onLoading();

    R response = await fetchData();

    onLoadingSuccess();

    clearDataIfNeeded();

    handleRefreshController();

    handleResponse(response);

    return response;
  }

  @override
  bool isFirstPage() => true;

  @override
  bool isEndOfPage() => false;

  @override
  void onRefreshData() {
    loadData();
  }

  @override
  void onLoadMore() {
    if (!isEndOfPage()) {
      // loadMore here.
    }
  }

  @override
  void handleRefreshController() {
    // no loadMore.
    refreshController.refreshCompleted();
    refreshController.loadComplete();
  }

  void clearDataIfNeeded() {
    if (isFirstPage()) data.clear();
  }
}
