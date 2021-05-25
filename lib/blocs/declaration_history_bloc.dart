import 'dart:async';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/declaration_history_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/global_cache.dart';
import 'bloc.dart';
import 'bloc_impl/event_type.dart';
import 'bloc_impl/stream_event.dart';

class DeclarationHistoryBloc
    implements Bloc {
  StreamController<StreamEvent<DeclarationHistoryModel>> _getDeclarationList =
      StreamController();
  Stream<StreamEvent<DeclarationHistoryModel>> get getDeclarationListStream =>
      _getDeclarationList.stream;

  getDeclarationList(String fromDate, String toDate, int count) {

    ApiService(
        ApiConstants.GET_DECLARATION_HIS,
        {
          "FromDateStr": fromDate,
          "ToDateStr": toDate,
          "Mobile": GlobalCache().loginData.userInfo.mobile,
          "PageIndex": 1,
          "PageSize": count
        },
        null)
        .getResponse()
        .then((data) {
      var error = "Có lỗi khi lấy dữ liệu";
      JDIResponse response = data.data;
      if (data.status == Status.SUCCESS) {
        if (response != null && response.ErrorCode == "000000") {
          List<DeclarationHistoryModel> data =
          response.Data.map((e) => DeclarationHistoryModel.fromJson(e))
              .toList();
          _getDeclarationList.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded, data: data));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getDeclarationList.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getDeclarationList.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getDeclarationList.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }
  // getDeclarationList({bool isRefresh = false}) {
  //   String toDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  //   String fromDate = DateFormat("dd/MM/yyyy")
  //       .format(DateTime.now().subtract(Duration(days: 60)));
  //   if (isRefresh) refreshPage();
  //   requestStarted(); //todo
  //   ApiService(
  //           ApiConstants.GET_DECLARATION_HIS,
  //           {
  //             "FromDateStr": fromDate,
  //             "ToDateStr": toDate,
  //             "Mobile": GlobalCache().loginData.userInfo.mobile,
  //             // "Mobile": "0966888888",
  //             "PageIndex": pageIndex,
  //             "PageSize": AppConstants.PAGE_SIZE
  //           },
  //           null)
  //       .getResponse()
  //       .then((data) {
  //     requestFinished(); //todo
  //     var error = "Có lỗi khi lấy dữ liệu";
  //     JDIResponse response = data.data;
  //     if (data.status == Status.SUCCESS) {
  //       if (response != null && response.ErrorCode == "000000") {
  //         List<DeclarationHistoryModel> data =
  //             response.Data.map((e) => DeclarationHistoryModel.fromJson(e))
  //                 .toList();
  //         //todo
  //         setList(data, AppConstants.PAGE_SIZE);
  //         increasePage();
  //         _getDeclarationList.sink
  //             .add(StreamEvent(eventType: StreamEventType.Loaded));
  //       } else {
  //         if (response != null)
  //           error = response.ErrorMessage.isNotEmpty
  //               ? response.ErrorMessage
  //               : response.ErrorCode;
  //         _getDeclarationList.sink.add(
  //             StreamEvent(eventType: StreamEventType.Error, message: error));
  //       }
  //     } else if (data.status == Status.LOADING) {
  //       _getDeclarationList.sink.add(StreamEvent(
  //         eventType: StreamEventType.Loading,
  //       ));
  //     } else {
  //       if (data != null)
  //         error = response.ErrorMessage.isNotEmpty
  //             ? response.ErrorMessage
  //             : response.ErrorCode;
  //       _getDeclarationList.sink
  //           .add(StreamEvent(eventType: StreamEventType.Error, message: error));
  //     }
  //   });
  // }

  @override
  void dispose() {
    _getDeclarationList.close();
  }
}
