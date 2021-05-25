import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:rxdart/subjects.dart';

class ResetPasswordBloc {
  ApiResultListener _listener;
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  resetPassword(String phoneNumber, String passWord, String domain) {
    ApiService(
            ApiConstants.RESET_PWD,
            {"UserName": phoneNumber, "NewPwd": passWord, "DomainName": domain},
            response)
        .execute();
  }

  void init(ApiResultListener impl) {
    _listener = impl;
    response.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        _listener.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            List<dynamic> result =
                response.Data.map((e) => JDIResponse.fromJson(e)).toList();
            _listener.onSuccess(result);
          } else {
            _listener.onError(response.ErrorMessage ?? response.ErrorCode);
          }
        } else {
          _listener.onError("Có lỗi xảy ra.");
        }
      } else if (data.status == Status.ERROR) {
        _listener.onError("Có lỗi xảy ra.");
      }
    });
  }

  dispose() {
    response.close();
  }
}
