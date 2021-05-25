import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/user/info_user.dart';

import 'package:checkin/model/beans/user/user_login_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:rxdart/subjects.dart';
import '../bloc.dart';

class UpdateProfileBloc implements Bloc {
  final _subjectUpdateProfile = BehaviorSubject<ApiResponse<JDIResponse>>();

  onUpdateProfile(UserInfo infoUser)

  {
    ApiService(
            ApiConstants.UPDATE_PROFILE,
            {
              "FullName": infoUser.fullName,
              "IdentifyNo": infoUser.profile.identifyNo,
              "InsuranceNo": infoUser.profile.insuranceNo,
              "BirthdayStr": infoUser.profile.birthdayStr,
              "Gender": infoUser.profile.gender,
              "Country": infoUser.profile.country,

              "ProvinceId": infoUser.profile.provinceId,
              "ProvinceIdStr": infoUser.profile.provinceId,
              "ProvinceName": infoUser.profile.provinceName,

              "DistrictId": infoUser.profile.districtId,
              "DistrictIdStr": infoUser.profile.districtIdStr,
              "DistrictName": infoUser.profile.districtName,

              "CommuneId": infoUser.profile.communeId,
              "CommuneIdStr": infoUser.profile.communeIdStr,
              "CommuneName": infoUser.profile.communeName,

              "Address": infoUser.profile.address,
              "Mobile": infoUser.mobile,
              "Email": infoUser.email,
              "EmployeeCode": infoUser.employeeCode,
            },
            _subjectUpdateProfile)
        .execute();
  }

  void onUpdateProfileListen(ApiResultListener impl) {
    _subjectUpdateProfile.listen((data) {
      if (data == null || data.status == Status.LOADING) {
        impl.onRequesting();
      }
      else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == "000000") {
            List<dynamic> result = response.Data.map((e) => JDIResponse.fromJson(e)).toList();

            impl.onSuccess(result);
          } else {
            impl.onError(response.ErrorMessage??response.ErrorCode);
          }
        } else {
          impl.onError('Có lỗi xảy ra.');
        }
      }
      else {
        impl.onError("Có lỗi xảy ra.");
      }
    });
  }

  @override
  void dispose() {
    _subjectUpdateProfile.close();
  }
}
