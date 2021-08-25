abstract class ListAction<R> {
  bool isFirstPage();
  bool isEndOfPage();

  void onLoading();
  void onRefreshData();
  void onLoadingSuccess();
  void onLoadMore();
  void handleRefreshController();
  void handleResponse(R response);
}
