import 'package:checkin/blocs/bloc.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:rxdart/rxdart.dart';

class ChangeAvatarBloc implements Bloc {
  final _subjectChangeAvatar = BehaviorSubject<ApiResponse<JDIResponse>>();
  ApiResultListener apiResultListener;

  void setListener(ApiResultListener listener) {
    apiResultListener = listener;
  }

  updateAvatar(String imgPath ) {
    ApiService(ApiConstants.UPDATE_AVATAR, {"AvatarUrl": imgPath},
            _subjectChangeAvatar)
        .getResponse()
        .then((data) {
      if (data == null || data.status == Status.LOADING) {
        apiResultListener.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            apiResultListener.onSuccess(null);
          } else {
            apiResultListener.onError("Cập nhật hình đại diện thất bại");
          }
        } else {
          apiResultListener.onError("Cập nhật hình đại diện thất bại");
        }
      } else if (data.status == Status.ERROR){
        apiResultListener.onError("Cập nhật hình đại diện thất bại");
      }
    });
  }

  @override
  void dispose() {
    _subjectChangeAvatar.close();
  }
}
