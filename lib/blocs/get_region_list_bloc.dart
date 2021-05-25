import 'dart:async';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/commune_model.dart';
import 'package:checkin/model/beans/country_model.dart';
import 'package:checkin/model/beans/district_model.dart';
import 'package:checkin/model/beans/province_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class GetRegionListBloc {
  Future<List<CountryModel>> getListCountry(String text) {
    return ApiService(
        ApiConstants.GET_LIST_COUNTRY, {}, null).getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<CountryModel> result =
            jdiResponse.Data.map((e) => CountryModel.fromJson(e))
                .toList()
                .where((element) => element.name.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return result;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    });
  }
  Future<List<ProvinceModel>> getListProvince(String text) {
    return ApiService(
        ApiConstants.GET_LIST_PROVINCE,
        {
        },
        null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<ProvinceModel> result =
            jdiResponse.Data.map((e) => ProvinceModel.fromJson(e))
                .toList()
                .where((element) => element.name.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return result;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    });
  }
  Future<List<DistrictModel>> getListDistrict(String text, String provinceIdStr) {
    return ApiService(
        ApiConstants.GET_LIST_DISTRICT,
        {
          "ProvinceIdStr": provinceIdStr
        },
        null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<DistrictModel> result =
            jdiResponse.Data.map((e) => DistrictModel.fromJson(e))
                .toList()
                .where((element) => element.name.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return result;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    });
  }
  Future<List<CommuneModel>> getListCommune(String text, String districtIdStr) {
    return ApiService(
        ApiConstants.GET_LIST_COMMUNE,
        {
          "DistrictIdStr": districtIdStr
        },
        null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<CommuneModel> result =
            jdiResponse.Data.map((e) => CommuneModel.fromJson(e))
                .toList()
                .where((element) => element.name.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return result;
          } else {
            return [];
          }
        } else {
          return [];
        }
      } else {
        return [];
      }
    });
  }
}
