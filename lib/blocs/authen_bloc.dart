import 'dart:convert';

import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/user/user_login_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/subjects.dart';
import 'bloc.dart';

class LoginBloc implements Bloc {
  final _subjectLogin = BehaviorSubject<ApiResponse<JDIResponse>>();
  // final _subjectAuthenData = BehaviorSubject<ApiResponse<UserLogInModel>>();

  loginAccount({String userName, String passWord, String domainName}) {
    ApiService(
            ApiConstants.SIGNIN_ACCOUNT,
      {
        "Username": userName,
        "Password": passWord,
        "DomainName": domainName
      }
    , _subjectLogin)
        .execute();
  }

  // BehaviorSubject<ApiResponse<UserLogInModel>> get subjectAuthenData =>
  //     _subjectAuthenData;

  void onLoginAccountListen(ApiResultListener impl) {
    _subjectLogin.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        impl.onRequesting();
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<LoginModel> result =
                response.Data.map((e) => LoginModel.fromJson(e)).toList();
            GlobalCache().setData(result.first);
            Hive.box(AppConstants.HIVE_APP_BOX).put(
                AppConstants.HIVE_USER_DATA, jsonEncode(result[0].toJson()));
            impl.onSuccess(result);
          } else {
            impl.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          impl.onError("Có lỗi xảy ra");
        }
      } else if (data.status == Status.ERROR){
        impl.onError("Có lỗi xảy ra");
      }
    });
  }

  // loadData() async {
  //   final data =
  //       Hive.box(AppConstants.HIVE_USER_BOX).get(AppConstants.HIVE_MEMBER_DATA);
  //   if (data == null) {
  //     _subjectAuthenData.sink
  //         .add(ApiResponse<UserLogInModel>(Status.SUCCESS, null, null));
  //     return;
  //   } else {
  //     final memberData = UserLogInModel.fromJson(jsonDecode(data));
  //     GlobalCache().setData(memberData);
  //     _subjectAuthenData.sink
  //         .add(ApiResponse<UserLogInModel>(Status.SUCCESS, memberData, null));
  //     return;
  //   }
  // }

  @override
  void dispose() {
    // _subjectAuthenData.close();
    _subjectLogin.close();
  }
}
