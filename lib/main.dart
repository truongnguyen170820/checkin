import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:isolate';

import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/beans/user/user_login_model.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/utils/screen/screen_utils.dart';
import 'package:checkin/views/user/login_account_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> handleShowNotification(title, body) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'defaultChannel', 'defaultChannel', 'defaultChannel',
      importance: Importance.Max,
      priority: Priority.High,
      ticker: 'ticker',
      playSound: true,
      sound: RawResourceAndroidNotificationSound('alert'));
  var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  var platformChannelSpecifics = NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: '');
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    if (message.containsKey('notification')) {
      // Handle notification message
      final notification = message['notification'] as Map<dynamic, dynamic>;
      if (notification.containsKey('title') &&
          notification.containsKey('body')) {
        handleShowNotification(
            notification['title'] as String, notification['body'] as String);
      }
    }
  }
  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  // Or do other work.
}

NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //init firebase message
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  var initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification: null);
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: null);
  //firebase crashlytics
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Isolate.current.addErrorListener(RawReceivePort((pair) async {
    final List<dynamic> errorAndStacktrace = pair;
    await FirebaseCrashlytics.instance.recordError(
      errorAndStacktrace.first,
      errorAndStacktrace.last,
    );
  }).sendPort);
  runZonedGuarded<Future<void>>(() async {
    // ...
  }, FirebaseCrashlytics.instance.recordError);
  //init Hive box & get cached data
  var appDocDirectory = await getApplicationDocumentsDirectory();
  Hive..init(appDocDirectory.path);
  await Hive.openBox(AppConstants.HIVE_APP_BOX);
  dynamic pathologyData =
      Hive.box(AppConstants.HIVE_APP_BOX).get(AppConstants.HIVE_PATHOLOGY_LIST);
  dynamic loginData =
      Hive.box(AppConstants.HIVE_APP_BOX).get(AppConstants.HIVE_USER_DATA);

  checkAppCache(pathologyData: pathologyData, loginData: loginData);
  //
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(MyApp());
  });
}

checkAppCache({
  dynamic pathologyData,
  dynamic loginData,
}) {
  if (pathologyData != null) {
    List<dynamic> temp = jsonDecode(pathologyData);
    List<PathologyModel> pathologyList =
        temp.map((e) => PathologyModel.fromJson(e)).toList();
    GlobalCache().pathologyList = pathologyList;
    if (loginData != null) {
      final data = LoginModel.fromJson(jsonDecode(loginData));
      GlobalCache().setData(data);
    }
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: ColorUtils.MAIN_GRADIENT_1));
    firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        if (message.containsKey('notification')) {
          // Handle notification message
          final notification = message['notification'] as Map<dynamic, dynamic>;
          if (notification.containsKey('title') &&
              notification.containsKey('body')) {
            handleShowNotification(notification['title'] as String,
                notification['body'] as String);
          }
        }
      },
    );

    firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });

    return MaterialApp(
      title: 'Khảo Sát',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SFUIText'),
      builder: (BuildContext context, Widget child) {
        final data = MediaQuery.of(context).copyWith(textScaleFactor: 1.0);
        ScreenUtil.init(context,
            width: 375, height: 812, allowFontScaling: true);
        return MediaQuery(data: data, child: child);
      },
      home: LoginAccountView(),
    );
  }
}
