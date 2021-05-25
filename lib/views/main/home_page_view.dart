import 'package:checkin/blocs/notification_count_bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/repo/api_service.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/utils/screen/screen_utils.dart';
import 'package:checkin/views/main/declaration_history_view.dart';
import 'package:checkin/views/main/declare_manager.dart';
import 'package:checkin/views/main/employee_has_problem_view.dart';
import 'package:checkin/views/main/employee_not_declared_view.dart';
import 'package:checkin/views/main/notification_page_view.dart';
import 'package:checkin/views/main/report_info_view.dart';
import 'package:checkin/views/user/change_password_view.dart';
import 'package:checkin/views/user/login_account_view.dart';
import 'package:checkin/views/user/user_profile_view.dart';
import 'package:checkin/widget/circle_avatar.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:flutter/material.dart';

import 'add_declaration_view.dart';

class HomePageView extends StatefulWidget {
  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  double screenHeight;

  List<PathologyModel> pathologyList = [];
  @override
  void initState() {
    super.initState();
    NotificationCountBloc().getNotificationCount();
    NotificationCountBloc().connect();
    NotificationCountBloc().checkMQTTDisconnect();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Trang chủ',
          style: FontUtils.SEMIBOLD.copyWith(fontSize: setSp(18)),
        ),
        centerTitle: true,
        actions: [
          Container(
            padding: EdgeInsets.only(right: setWidth(8)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationPage()))
                    .then((value) {
                  NotificationCountBloc().getNotificationCount();
                });
              },
              child: notifyIcon(),
            ),
          ),
        ],
        leading: Builder(builder: (BuildContext context) {
          return Container(
            width: setWidth(35),
            height: setWidth(35),
            padding: EdgeInsets.all(setWidth(9)),
            child: IconButton(
              icon: Image.asset(
                getAssetsIcon("drawer.png"),
                width: setWidth(35),
                height: setWidth(35),
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            ),
          );
        }),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      drawer: mainDrawer(),
      body: Column(
        children: [
          Container(
            width: ScreenUtil.screenWidth,
            height: screenHeight * 0.6,
            decoration: BoxDecoration(color: ColorUtils.MAIN_GRADIENT_2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: screenHeight * 0.13,
                  child: Column(
                    children: [
                      Image.network(
                        ApiConstants()
                            .getFullImage(GlobalCache().loginData.domainLogo),
                        height: screenHeight * 0.1 * 0.7,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(
                        height: setHeight(8),
                      ),
                      Text(
                        GlobalCache().loginData.companyName?.toUpperCase() ??
                            "",
                        style: FontUtils.BOLD.copyWith(fontSize: setSp(18)),
                      )
                    ],
                  ),
                ),
                Container(
                  height: screenHeight * 0.37,
                  child: Image.asset(
                    getAssetsImage("5k.png"),
                    width: ScreenUtil.screenWidth,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    menuItem("assets/icons/khai_bao.png", "Khai báo y tế",
                        () => pushTo(context, AddDeclarationView())),
                    menuItem("assets/icons/phan_anh.png", "Phản ánh",
                        () => pushTo(context, ReportInfomationView())),
                    menuItem("assets/icons/lich_su.png", "Lịch sử khai báo",
                        () => pushTo(context, DeclarationHistoryView())),
                  ],
                ),
                if (GlobalCache().loginData.userInfo.isManager)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      menuItem(
                          "assets/icons/ql_khai_bao.png",
                          "Quản lý khai báo",
                          () => pushTo(context, DeclareManager())),
                      menuItem(
                          "assets/icons/chua_khai_bao.png",
                          "Chưa khai báo",
                          () => pushTo(context, EmployeeNotDeclaredView())),
                      menuItem(
                          "assets/icons/yeu_to_dich_te.png",
                          "Yếu tố dịch tễ",
                          () => pushTo(context, EmployeeHasProblemView())),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget menuItem(String icon, String label, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Image.asset(
            icon,
            width: setWidth(70),
            height: setWidth(70),
          ),
          SizedBox(
            height: setHeight(5),
          ),
          Container(
              width: setWidth(70),
              child: Text(
                label,
                style: FontUtils.MEDIUM.copyWith(fontSize: setSp(13)),
                textAlign: TextAlign.center,
              ))
        ],
      ),
    );
  }

  Widget mainDrawer() {
    return Drawer(
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfileView())).then((value) {
                setState(() {});
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                  left: setWidth(20),
                  top: setHeight(56),
                  right: setWidth(25),
                  bottom: setHeight(30)),
              child: Row(
                children: [
                  circleAvatar(
                      GlobalCache().loginData.userInfo.profile.avatarUrl ?? "",
                      GlobalCache().loginData.userInfo.profile.fullName ?? "",
                      radius: 30),
                  SizedBox(width: setWidth(8)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GlobalCache().loginData.userInfo.fullName ?? "",
                        style: FontUtils.BOLD,
                      ),
                      Text(GlobalCache().loginData.userInfo.mobile ?? "",
                          style: FontUtils.BOLD)
                    ],
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: setWidth(24), right: setWidth(24)),
            child: Column(
              children: [
                drawerItem("Thông tin cá nhân", "profile.png", onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserProfileView()))
                      .then((value) {
                    setState(() {});
                  });
                }),
                drawerItem("Đổi mật khẩu", "change_password.png", onTap: () {
                  pushTo(context, ChangePasswordView());
                }),
              ],
            ),
          ),
          Spacer(),
          CustomButton(
            title: "Đăng xuất",
            height: setHeight(42),
            width: setWidth(200),
            bgColor: Colors.red,
            onTap: () {
              pop(context);
              showConfirmDialog();
            },
          ),
          Container(
            padding: EdgeInsets.only(top: setHeight(18), bottom: setHeight(24)),
            child: Text("Phiên bản 1.0.0",
                style: FontUtils.NORMAL.copyWith(
                    color: ColorUtils.TEXT_NORMAL, fontSize: setSp(12)),
                textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }

  showConfirmDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              width: setWidth(310),
              padding: EdgeInsets.all(
                setHeight(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        size: 30,
                      ),
                      SizedBox(
                        width: setWidth(10),
                      ),
                      Text(
                        "Đăng xuất",
                        style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Text(
                    "Bạn có muốn đăng xuất khỏi tài khoản đang sử dụng?",
                    style: FontUtils.NORMAL,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        title: "Không",
                        width: setWidth(100),
                        height: setHeight(40),
                        bgColor: Colors.grey,
                        onTap: () {
                          pop(context);
                        },
                      ),
                      CustomButton(
                        title: "Có",
                        width: setWidth(100),
                        height: setHeight(40),
                        onTap: () {
                          ApiService(ApiConstants.SIGNOUT_ACCOUNT, {}, null)
                              .getResponse();
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginAccountView()),
                              (route) => false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  drawerItem(String title, String icon, {Function onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: setHeight(16), top: setHeight(16)),
        child: Row(
          children: [
            Image.asset(getAssetsIcon(icon),
                height: setHeight(30), width: setWidth(25)),
            SizedBox(width: setWidth(16)),
            Text(
              title,
              style: FontUtils.MEDIUM,
            ),
          ],
        ),
      ),
    );
  }

  Widget notifyIcon() {
    return Stack(
      children: [
        IconButton(
          icon: Image.asset(
            getAssetsIcon("notify_icon.png"),
            width: setWidth(45),
            height: setHeight(49),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: StreamBuilder(
            stream: NotificationCountBloc().getNotificationCountStream,
            initialData: 0,
            builder: (context, snapshot) {
              int notificationUnread;
              if (snapshot.hasData) {
                notificationUnread = snapshot.data;
                if (notificationUnread == 0) {
                  return Container();
                } else
                  return Container(
                    constraints: BoxConstraints(
                      minWidth: setWidth(18),
                      minHeight: setHeight(18),
                    ),
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: ColorUtils.RED_TEXT),
                    alignment: Alignment.center,
                    child: notificationUnread > 99
                        ? Text(
                            '99+',
                            style: FontUtils.BOLD.copyWith(
                                fontSize: setSp(10), color: Colors.white),
                            textAlign: TextAlign.center,
                          )
                        : Text(
                            '$notificationUnread',
                            style: FontUtils.BOLD.copyWith(
                                fontSize: setSp(12), color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                  );
              } else
                return Container();
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
