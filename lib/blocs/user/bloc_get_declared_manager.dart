import 'dart:async';
import 'package:checkin/blocs/base_list_bloc.dart';
import 'package:checkin/blocs/bloc.dart';
import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/views/user/user_has_declared.dart';

class UserHasDeclaredBloc extends BaseListBlock<UserHasDeclared> implements Bloc {


  StreamController<StreamEvent<UserHasDeclared>> _getUserHasDeclaredStream = StreamController.broadcast();

  Stream<StreamEvent<UserHasDeclared>> get getHasDeclaredStream => _getUserHasDeclaredStream.stream;

  getUserHasDeclaredList(String fromDateSrt, String  toDateSrt,
      {bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted();//todo
    ApiService(
        ApiConstants.GET_DECLAREMANAGER,
        {
          "PageIndex": pageIndex,
          "PageSize": AppConstants.PAGE_SIZE,
          "FromDateStr": fromDateSrt,
          "ToDateStr": toDateSrt,

        },
        null)
        .getResponse()
        .then((data) {
      requestFinished(); //todo
      var error = "Có lỗi khi lấy dữ liệu";
      JDIResponse response = data.data;
      if (data.status == Status.SUCCESS) {
        if (response != null && response.ErrorCode == "000000") {
         var data = response.Data.map((e) => UserHasDeclared.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();
          _getUserHasDeclaredStream.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        }
        else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getUserHasDeclaredStream.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      }
      else if (data.status == Status.LOADING) {
        _getUserHasDeclaredStream.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      }
      else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getUserHasDeclaredStream.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getUserHasDeclaredStream.close();
  }
}
