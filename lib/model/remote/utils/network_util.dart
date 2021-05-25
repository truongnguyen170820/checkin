import 'dart:io';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

class NetworkUtil {
  Dio _dio;

  NetworkUtil() {
    ///Create Dio Object using baseOptions set receiveTimeout,connectTimeout
    BaseOptions options =
        BaseOptions(receiveTimeout: 25000, connectTimeout: 25000);
    options.baseUrl = ApiConstants.BASE_URL;
    _dio = Dio(options);
    _dio.interceptors.add(LogInterceptor());
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  ///used for calling Get Request
  Future<Response> get(String url, Map<String, dynamic> params,
      {Map<String, String> headers, CancelToken cancelToken}) async {
    Response response;
    if(cancelToken!=null){
      response = await _dio.get(url,
          queryParameters: params,
          cancelToken: cancelToken,
          options: Options(responseType: ResponseType.json, headers: headers));
    } else
      response = await _dio.get(url,
        queryParameters: params,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }

  ///used for calling post Request
  Future<Response> post(String url,
      {Map<String, String> headers,
      Map<String, dynamic> mapData,
      FormData formData,
      CancelToken cancelToken}) async {
    try {
      Response response;
      if (mapData != null)
        response = await _dio.post(url,
            data: mapData,
            cancelToken: cancelToken,
            options: Options(
                responseType: ResponseType.json, headers: headers));
      else if (formData != null)
        response = await _dio.post(url,
            data: formData,
            cancelToken: cancelToken,
            options: Options(
                responseType: ResponseType.json, headers: headers));
print(response);
      return response;
    } on DioError catch(e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        return Response(
            statusCode: 999,
            statusMessage: "Lỗi timeout, vui lòng kiểm tra kết nối internet và thử lại!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_TIMEOUT, "Lỗi timeout, vui lòng kiểm tra kết nối internet và thử lại!", 0, null)
        );
      } else if (DioErrorType.RESPONSE == e.type) {
        return Response(
            statusCode: 999,
            statusMessage: "Có lỗi từ máy chủ, vui lòng thử lại sau!",
            data: JDIResponse.create(AppConstants.JDI_SERVER_ERROR, "Có lỗi từ máy chủ, vui lòng thử lại sau!", 0, null)
        );
      } else if (DioErrorType.DEFAULT == e.type && e.message.contains('SocketException')) {
        return Response(
            statusCode: 999,
            statusMessage: "Không có kết nối internet vui lòng thử lại sau!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_SOCKET_EXCEPTION, "Không có kết nối internet vui lòng thử lại sau!", 0, null)
        );
      } else {
        return Response(
            statusCode: 999,
            statusMessage: "Có lỗi kết nối máy chủ vui lòng thử lại sau!",
            data: JDIResponse.create(AppConstants.JDI_ERROR_UNDEFINED, "Có lỗi kết nối máy chủ vui lòng thử lại sau!", 0, null)
        );
      }
    }

  }

  Future<Response> put(String url,
      {Map<String, String> headers,
      Map<String, dynamic> mapData,
      FormData formData}) async {
    Response response = await _dio.put(url,
        data: (mapData == null) ? formData : mapData,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }

  Future<Response> delete(String url, Map<String, dynamic> data,
      {Map<String, String> headers}) async {
    Response response = await _dio.delete(url,
        data: data,
        options: Options(responseType: ResponseType.json, headers: headers));
    return response;
  }
}

final networkUtil = NetworkUtil();
