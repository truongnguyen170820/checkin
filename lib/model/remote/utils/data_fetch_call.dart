import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';

abstract class DataFetchCall<T> {
  bool shouldFetchFromDB();

  void loadFromDB();

  Future<Response> createApiAsync({CancelToken cancelToken});

  void onSuccess(T response);

  T parseJson(Response response);

  Subject<ApiResponse<T>> observable;

  DataFetchCall(Subject<ApiResponse<T>> observable) {
    this.observable = observable;
  }

  void execute() {
    if (shouldFetchFromDB()) {
      loadFromDB();
    } else {
      observable.sink.add(ApiResponse.loading<T>());
      getResponse().then((onValue) {
        observable.sink.add(onValue);
      }).catchError((error) {
        // print(error);
      });
    }
  }

  Future<ApiResponse<T>> getResponse({CancelToken cancelToken}) async {
    try {
      Response response = await createApiAsync(cancelToken: cancelToken);
      print("Response : ${response.data}");
      if (response.statusCode >= 200 && response.statusCode < 300) {
        T responseModel = parseJson(response);
        onSuccess(responseModel);
        return ApiResponse.success<T>(responseModel);
      } else {
        return ApiResponse.failed<T>(Error(response.statusCode, response.statusMessage, response.statusMessage));
      }
    } catch (error, stacktrace) {
      // print(error);
      return ApiResponse.failed<T>(Error( 500, error.toString(), stacktrace.toString()));
    }
  }
}
