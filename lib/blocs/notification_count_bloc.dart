import 'dart:async';
import 'dart:convert';

import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/base_response.dart';
import 'package:checkin/model/beans/mqtt_model.dart';
import 'package:checkin/model/beans/notification/notification_count_model.dart';
import 'package:checkin/model/remote/utils/api_response.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'bloc.dart';

class NotificationCountBloc implements Bloc {
  final client = MqttServerClient.withPort('45.124.86.50','flutter_clien', 18883);
  StreamController _getNotificationCountStreamCtrl =
      StreamController<int>.broadcast();
  Stream<int> get getNotificationCountStream =>
      _getNotificationCountStreamCtrl.stream;
  static final NotificationCountBloc _singleton =
      NotificationCountBloc._internal();
  factory NotificationCountBloc() {
    return _singleton;
  }
  getNotificationCount() {
    ApiService(ApiConstants.COUNT_NOTIFY_UNREAD, {}, null)
        .getResponse()
        .then((response) {
      if (response != null && response.status == Status.SUCCESS) {
        JDIResponse jdiResponse = response.data;
        if (jdiResponse != null) {
          if (jdiResponse.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
            List<NotifycationCountModel> result =
                jdiResponse.Data.map((e) => NotifycationCountModel.fromJson(e))
                    .toList();
            if (result.length > 0)
              _getNotificationCountStreamCtrl.sink
                  .add(result[0].totalUnread ?? 0);
          } else {}
        } else {}
      } else {}
    });
  }

  NotificationCountBloc._internal();

  Future<MqttServerClient> connect() async {
    client.logging(on: false);
    client.keepAlivePeriod = 20;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    final connMess = MqttConnectMessage()
        .withClientIdentifier(GlobalCache().loginData.userInfo.idStr)
        .keepAliveFor(20)
        .withWillTopic('willtopic')
        .withWillMessage('My Will message')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;

    try {
      await client.connect('mqttClientUsr', 'tfUs2021');
      if (client.connectionStatus.state == MqttConnectionState.connected) {
        client.subscribe(
            "ecoface/notify/${GlobalCache().loginData.userInfo.idStr}",
            MqttQos.atLeastOnce);
        client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
          try {
            final MqttPublishMessage message = c[0].payload;
            final payload = MqttPublishPayload.bytesToStringAsString(
                message.payload.message);
            _getNotificationCountStreamCtrl.sink.add(MQTTModel.fromJson(jsonDecode(payload)).totalUnread);
          } on Exception catch (e) {
            print('Parse message failed');
          }
        });
      } else {
        client.disconnect();
      }
    } on Exception catch (e) {
      client.disconnect();
    }
    return client;
  }

  void onConnected() {
    print('MQTT Connected');
  }

  void onDisconnected() {
    print('MQTT Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTT Subscribed topic: $topic');
  }

  checkMQTTDisconnect() {
    new Timer.periodic(const Duration(seconds: 30), (Timer t) {
      try {
        if (client != null &&
            client.connectionStatus.state == MqttConnectionState.disconnected) {
          Connectivity().checkConnectivity().then((connectResult) {
            if (connectResult == ConnectivityResult.mobile ||
                connectResult == ConnectivityResult.wifi) {
              client.disconnect();
              client.connect('mqttClientUsr', 'tfUs2021');
            }
          });
        } else if (client != null &&
            client.getSubscriptionsStatus(
                    "ecoface/notify/${GlobalCache().loginData.userInfo.idStr}") ==
                MqttSubscriptionStatus.doesNotExist) {
          Connectivity().checkConnectivity().then((connectResult) {
            if (connectResult == ConnectivityResult.mobile ||
                connectResult == ConnectivityResult.wifi) {
              client.subscribe(
                  "ecoface/notify/${GlobalCache().loginData.userInfo.idStr}",
                  MqttQos.atLeastOnce);
              client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
                try {
                  final MqttPublishMessage message = c[0].payload;
                  final payload = MqttPublishPayload.bytesToStringAsString(
                      message.payload.message);
                  print("MQTT received:" + payload);
                  _getNotificationCountStreamCtrl.sink.add(MQTTModel.fromJson(jsonDecode(payload)).totalUnread);
                } on Exception catch (e) {
                  print('Parse message failed');
                }
              });
            }
          });
        }
      } catch (err) {
        print('Caught error: $err');
      }
    });
  }

  @override
  void dispose() {
    client.disconnect();
    _getNotificationCountStreamCtrl.close();
  }
}
