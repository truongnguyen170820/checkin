import 'package:checkin/blocs/bloc.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:rxdart/subjects.dart';

class ChangePwdUserBloc extends Bloc {
  final response = BehaviorSubject<ApiResponse<JDIResponse>>();

  executeChangePwd(String oldPwd, String newPwd) {
    ApiService(ApiConstants.CHANGE_PWD_USER,
            {"NewPassword": newPwd, "Password": oldPwd}, response)
        .execute();
  }

  void onChangePwdListen(ApiResultListener impl) {
    response.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        impl.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "US0014") {
            List<dynamic> result =
                response.Data.map((e) => JDIResponse.fromJson(e)).toList();
            impl.onSuccess(result);
          } else {
            impl.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          impl.onError("Có lỗi xảy ra");
        }
      } else {
        impl.onError("Có lỗi xảy ra");
      }
    });
  }

  @override
  void dispose() {
    response.close();
  }
}
