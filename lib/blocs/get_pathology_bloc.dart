import 'dart:async';
import 'dart:convert';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:hive/hive.dart';
import 'package:rxdart/rxdart.dart';
import 'bloc.dart';

class GetPathologyListBloc implements Bloc {
  StreamController _getPathologyStreamCtrl =
      StreamController<List<PathologyModel>>();
  final _subjectLogin = BehaviorSubject<ApiResponse<JDIResponse>>();

  Stream get getPathologyStream => _getPathologyStreamCtrl.stream;

  getPathologyList() {
    ApiService(ApiConstants.GET_LIST_PATHOLOGY, {}, _subjectLogin)
        .execute();}

  initListener() {
    _subjectLogin.listen((data) {
      if (data == null || data.status == Status.LOADING) {
      } else if (data.status == Status.SUCCESS) {
        JDIResponse response = data.data;
        if (response != null) {
          if (response.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<PathologyModel> result =
                response.Data.map((e) => PathologyModel.fromJson(e)).toList();
            _getPathologyStreamCtrl.sink.add(result);
            Hive.box(AppConstants.HIVE_APP_BOX)
                .put(AppConstants.HIVE_PATHOLOGY_LIST, jsonEncode(result));
            GlobalCache().setListPathology(result);
          } else {}
        } else {}
      } else if (data.status == Status.ERROR) {}
    });
  }

  @override
  void dispose() {
    _getPathologyStreamCtrl.close();
    _subjectLogin.close();
  }
}
