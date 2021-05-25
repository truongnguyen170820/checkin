import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/requests/declaration_request.dart';
import 'package:checkin/model/remote/requests/report_info_request.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:rxdart/subjects.dart';
import 'bloc.dart';

class ReportInfoBloc implements Bloc {
  final _subject = BehaviorSubject<ApiResponse<JDIResponse>>();

  reportInfo(ReportInfoRequest request) {
    ApiService(ApiConstants.ADD_REPORT_INFO, request.toJson(), _subject)
        .execute();
  }

  void initListener(ApiResultListener impl) {
    _subject.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        impl.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<dynamic> result =
                response.Data.map((e) => JDIResponse.fromJson(e)).toList();
            impl.onSuccess(result);
          } else {
            impl.onError(response.ErrorMessage ?? response.ErrorCode);
          }
        } else {
          impl.onError("Có lỗi xảy ra");
        }
      } else if (data.status == Status.ERROR) {
        impl.onError("Có lỗi xảy ra");
      }
    });
  }

  @override
  void dispose() {
    _subject.close();
  }
}
