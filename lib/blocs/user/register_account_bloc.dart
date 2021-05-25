import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:rxdart/subjects.dart';


class RegisterAccountBloc {
  ApiResultListener _listener;
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  registerAccount(String nameUser, String passWord, String companyCode,String phoneNumber,) {
    ApiService(
            ApiConstants.REGISTER,
            {
              "Username": phoneNumber,
              "Password": passWord,
              "DomainName": companyCode,
              "Mobile": phoneNumber,
            },
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
            _listener.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          _listener.onError("Có lỗi xảy ra, kiểm tra lại kết nối");
        }
      } else {

      }
    });
  }

  dispose() {
    response.close();
  }
}
