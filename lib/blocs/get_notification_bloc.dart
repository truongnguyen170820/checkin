import 'dart:async';
import 'package:checkin/blocs/base_list_bloc.dart';
import 'package:checkin/blocs/bloc.dart';
import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/notification/notification_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';

class NotificationBloc extends BaseListBlock<NotificationModel> implements Bloc {

  StreamController<StreamEvent<NotificationModel>> _getNotificationStream = StreamController.broadcast();

  Stream<StreamEvent<NotificationModel>> get getNotificationStream => _getNotificationStream.stream;
  getNotificationList({bool isRefresh = false}) {
    if (isRefresh) refreshPage();
    requestStarted();
    ApiService(
        ApiConstants.GET_NOTIFICATION,
        {
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
          List<NotificationModel> data = response.Data.map((e) => NotificationModel.fromJson(e)).toList();
          //todo
          setList(data, AppConstants.PAGE_SIZE);
          increasePage();
          _getNotificationStream.sink
              .add(StreamEvent(eventType: StreamEventType.Loaded));
        } else {
          if (response != null)
            error = response.ErrorMessage.isNotEmpty
                ? response.ErrorMessage
                : response.ErrorCode;
          _getNotificationStream.sink.add(
              StreamEvent(eventType: StreamEventType.Error, message: error));
        }
      } else if (data.status == Status.LOADING) {
        _getNotificationStream.sink.add(StreamEvent(
          eventType: StreamEventType.Loading,
        ));
      } else {
        if (data != null)
          error = response.ErrorMessage.isNotEmpty
              ? response.ErrorMessage
              : response.ErrorCode;
        _getNotificationStream.sink
            .add(StreamEvent(eventType: StreamEventType.Error, message: error));
      }
    });
  }

  @override
  void dispose() {
    _getNotificationStream.close();
  }
}
