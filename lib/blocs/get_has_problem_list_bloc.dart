import 'dart:async';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/employee_has_problem_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'base_list_bloc.dart';
import 'bloc.dart';
import 'bloc_impl/event_type.dart';
import 'bloc_impl/stream_event.dart';

class HasProblemListBloc extends BaseListBlock<HasProblemModel>
    implements Bloc {
  StreamController<StreamEvent<HasProblemModel>> _getHasProblemList =
      StreamController();
  Stream<StreamEvent<HasProblemModel>> get getHasProblemListStream =>
      _getHasProblemList.stream;

  getNotDeclarationList(String fromDate, String toDate,
      {bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted(); //todo
    ApiService(
            ApiConstants.GET_HAS_PROBLEM_LIST,
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
          List<HasProblemModel> data =
              response.Data.map((e) => HasProblemModel.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();
          _getHasProblemList.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getHasProblemList.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getHasProblemList.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getHasProblemList.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getHasProblemList.close();
  }
}
