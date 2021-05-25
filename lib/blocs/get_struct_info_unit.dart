import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/PositionModel.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/structdep_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';

class GetStructInfoListBloc {
  Future<List<PositionModel>> getListPosition(String text) {
    return ApiService(
        ApiConstants.GET_LIST_POSITION, {}, null).getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<PositionModel> result =
            jdiResponse.Data.map((e) => PositionModel.fromJson(e))
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
  Future<List<StructDepModel>> getListStructDep(String text) {
    return ApiService(
        ApiConstants.GET_STRUCT_DEPLIST,
        {
        },
        null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<StructDepModel> result =
            jdiResponse.Data.map((e) => StructDepModel.fromJson(e))
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