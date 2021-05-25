import 'dart:async';
import 'package:checkin/blocs/bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/user/info_user.dart';
import 'package:checkin/model/beans/user/user_login_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:flutter/cupertino.dart';

class GetUserProfileBloc implements Bloc {
  StreamController _getProfileStreamCtrl = StreamController<InfoUser>();
  Stream<InfoUser> get getProfileStream => _getProfileStreamCtrl.stream;

  getProfile(BuildContext context) {
    ApiService(ApiConstants.GET_PROFILE, {}, null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<InfoUser> result = jdiResponse.Data.map((e) => InfoUser.fromJson(e)).toList();
            if (result != null && result.length > 0) {
              _getProfileStreamCtrl.sink.add(result[0]);
            }
          } else {
            Utilites.showToast(
                context, jdiResponse.ErrorMessage ?? jdiResponse.ErrorCode);
          }
        } else {
          Utilites.showToast(context, "Không có dữ liệu");
        }
      } else {

      }
    });
  }

  @override
  void dispose() {
    _getProfileStreamCtrl.close();
  }
}
