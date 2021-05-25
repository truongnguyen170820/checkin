import 'dart:async';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/employee_not_declare_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'base_list_bloc.dart';
import 'bloc.dart';
import 'bloc_impl/event_type.dart';
import 'bloc_impl/stream_event.dart';

class NotDeclarationListBloc extends BaseListBlock<NotDeclareModel>
    implements Bloc {
  StreamController<StreamEvent<NotDeclareModel>> _getNotDeclarationList =
      StreamController();
  Stream<StreamEvent<NotDeclareModel>> get getNotDeclarationListStream =>
      _getNotDeclarationList.stream;

  getNotDeclarationList(String fromDate, String toDate,
      {bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted(); //todo
    ApiService(
            ApiConstants.GET_NOT_DECLARE_LIST,
            {
              "FromDateStr": fromDate,
              "ToDateStr": toDate,
              "PageIndex": pageIndex,
              "PageSize": AppConstants.PAGE_SIZE
            },
            null)
        .getResponse()
        .then((data) {
      requestFinished(); //todo
      var error = "Có lỗi khi lấy dữ liệu";
      JDIResponse response = data.data;
      if (data.status == Status.SUCCESS) {
        if (response != null && response.ErrorCode == "000000") {
          List<NotDeclareModel> data =
              response.Data.map((e) => NotDeclareModel.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();
          _getNotDeclarationList.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getNotDeclarationList.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getNotDeclarationList.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getNotDeclarationList.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getNotDeclarationList.close();
  }
}
