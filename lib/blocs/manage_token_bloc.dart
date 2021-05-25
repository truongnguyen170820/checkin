import 'dart:convert';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/notification/device_token_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class ManageTokenBloc implements Bloc {
  Subject _updateTokenSbj = BehaviorSubject<ApiResponse<JDIResponse>>();
  SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    _updateTokenSbj.close();
  }

  sendDeviceToken(DeviceTokenModel token) {
    _updateTokenSbj.listen((data) {
      if (data == null || data.status == Status.LOADING) {
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null &&
            response.ErrorCode == AppConstants.API_UPDATE_DEVICE_SUCCESS) {
          prefs.setString(
              AppConstants.PREF_DEVICE_TOKEN, json.encode(token.toJson()));
        } else {
          // String a=  response.ErrorCode;
          // String b = response.ErrorMessage;
        }
      } else {
        // String a="error";
      }
    });
    ApiService(ApiConstants.UPDATE_FIREBASE_TOKEN_ID, token.toJson(),
            _updateTokenSbj)
        .execute();
  }

  checkTokenSaved(String token, int platformOS) {
    if (token != null && token.isNotEmpty) {
      String storeToken = prefs.get(AppConstants.PREF_DEVICE_TOKEN);
      if (storeToken != null && storeToken.isNotEmpty) {
        var tokenInfo = DeviceTokenModel.fromJson(json.decode(storeToken));
        if (tokenInfo.devicePushId != token) {
          prefs.remove(AppConstants.PREF_DEVICE_TOKEN);
          sendDeviceToken(DeviceTokenModel(token, platformOS));
        }
      } else {
        sendDeviceToken(DeviceTokenModel(token, platformOS));
      }
    }
  }
}
