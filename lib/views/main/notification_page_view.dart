import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/blocs/get_notification_bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/notification/notification_model.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/widget/custom_loading.dart';
import 'package:checkin/widget/fail_widget.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  NotificationBloc bloc = NotificationBloc();
  List<NotificationModel> listData;
  @override
  void initState() {
    listData = [];
    super.initState();
    bloc.getNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: StreamBuilder(
            stream: bloc.getNotificationStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                StreamEvent event = snapshot.data;
                switch (event.eventType) {
                  case StreamEventType.Loading:
                    return LoadingWidget();
                    break;
                  case StreamEventType.Error:
                    return InkWell(
                      child: FailWidget(mess: event.message),
                      onTap: () => bloc.getNotificationList(),
                    );
                    break;
                  case StreamEventType.Loaded:
                    if (bloc.listData.length == 0)
                      return Center(
                        child: Text('Không có thông tin dịch vụ'),
                      );
                    listData = bloc.listData;
                    return RefreshIndicator(
                      onRefresh: _refreshPage,
                      child: ListView.builder(
                          itemCount: bloc.getListLength(),
                          itemBuilder: (context, index) {
                            if (bloc.canLoadMore(index, bloc.getListLength())) {
                              bloc.getNotificationList();
                              return customLoading;
                            }
                            return _itemNotification(listData[index]);
                          }),
                    )
                        //   Container(
                        //   child: SmartRefresher(
                        //     controller: controller,
                        //     enablePullDown: true,
                        //     header: CustomHeader(
                        //       builder: (context, mode) {
                        //         return customLoading;
                        //       },
                        //     ),
                        //     onRefresh: _refreshPage,
                        //     child: ListView.builder(
                        //         itemCount: bloc.getListLength(),
                        //         itemBuilder:(context , index){
                        //           if (bloc.canLoadMore(index, bloc.getListLength())) {
                        //             bloc.getNotificationList();
                        //             return customLoading;
                        //           }
                        //           var listData = bloc.listData;
                        //          listData.forEach((element) {
                        //            print('1ouf${element}');
                        //          });
                        //           return _itemNotification(listData[index]);
                        //         }),
                        //   ),
                        // )
                        ;
                    break;
                }

                return Center(
                    child: CupertinoActivityIndicator(
                  radius: 15,
                ));
              } else {
                return Center(
                  child: Text('Không có thông tin dịch vụ'),
                );
              }
            }),
      ),
    );
  }

  Widget _itemNotification(NotificationModel model) {
    bool isRead;
    if (model.status == 0) {
      isRead = false;
    } else {
      isRead = true;
    }
    return InkWell(
      child: Container(
        width: double.infinity,
        color: model.status != 0
            ? ColorUtils.WHITE
            : ColorUtils.backgroundNotification.withOpacity(0.3),
        padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
        child: Column(
          children: [
            Container(
              height: setHeight(1),
              color: ColorUtils.noted_boderColor_regis,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: setHeight(5)),
              child: Row(
                children: [
                  Container(
                    height: setWidth(36),
                    width: setWidth(36),
                    padding: EdgeInsets.all(8),
                    child: Image.asset(
                      getAssetsIconNotication(iconNotification(model.type)),
                    ),
                    decoration: BoxDecoration(
                        color: colorNotification(model.type).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(setWidth(12))),
                  ),
                  SizedBox(
                    width: setWidth(8),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: FontUtils.NORMAL,
                        ),
                        Text(
                          model.content,
                          style: FontUtils.NORMAL.copyWith(
                              fontSize: setSp(12),
                              color: ColorUtils.text_regis),
                        ),
                        Text(
                          model.sendDateStr ?? '',
                          style: FontUtils.NORMAL.copyWith(
                              color: ColorUtils.text_regis,
                              fontSize: setSp(12)),
                        ),
                        // Text(
                        //   model.sendDateStr?.substring(10, 15) ?? '',
                        //   style: FontUtils.NORMAL.copyWith(
                        //       color: ColorUtils.text_regis,
                        //       fontSize: setSp(12)),
                        // )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (model.status == 0) {
          setState(() {
            model.status = 1;
          });
          ApiService(
                  ApiConstants.RED_NOTIFICATION,
                  {
                    "IdStrList": [model.idStr]
                  },
                  null)
              .getResponse();
        }
      },
    );
  }

  String iconNotification(int model) {
    String icon;
    switch (model) {
      case 1:
        icon = 'ic_kbyt.png';
        break;
      case 2:
        icon = 'ic_checkin.png';
        break;
      case 3:
        icon = 'ic_notifi.png';
        break;
      case 4:
        icon = 'ic_notifi.png';
        break;
      default:
        icon = 'ic_hello.png';
    }
    return icon;
  }

  Color colorNotification(int model) {
    Color icon;
    switch (model) {
      case 1:
        icon = ColorUtils.MAIN_GRADIENT_1;
        break;
      case 2:
        icon = ColorUtils.NOTIFI_CHECKIN;
        break;
      case 3:
        icon = ColorUtils.NOTIFI_NOT_DECLARE;
        break;
      case 4:
        icon = ColorUtils.NOTIFI_NOT_DECLARE;
        break;
      default:
        icon = ColorUtils.NOTIFI_COMMON;
    }
    return icon;
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: ColorUtils.WHITE,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          size: 30,
          color: ColorUtils.TEXT_NORMAL,
        ),
      ),
      title: Text(
        "Thông báo",
        style: FontUtils.SEMIBOLD.copyWith(
          fontSize: setSp(18),
        ),
      ),
      centerTitle: true,
      elevation: 0.0,
      actions: [
        InkWell(
            child: Image.asset(
              getAssetsIcon('ic_notification.png'),
              height: setWidth(19),
              width: setWidth(19),
            ),
            onTap: () {
              List<NotificationModel> notificationUnreads = [];
              List<String> listidSrtNotifi = [];
              listData.forEach((element) {
                if (element.status == 0) {
                  notificationUnreads.add(element);
                  listidSrtNotifi.add(element.idStr);
                }
              });
              setState(() {
                notificationUnreads.forEach((element) {
                  element.status = 1;
                });
              });
              print('2ouf${listidSrtNotifi}');
              ApiService(ApiConstants.RED_NOTIFICATION,
                      {"IdStrList": listidSrtNotifi}, null)
                  .getResponse();
            }),
        SizedBox(
          width: setWidth(22),
        )
      ],
    );
  }

  Future<Null> _refreshPage() async {
    bloc.getNotificationList(isRefresh: true);
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
    // controller.dispose();
  }
}
