abstract class ApiResultListener<T> {
  void onRequesting();
  void onSuccess(List<T> response);
  void onError(String message);
}
