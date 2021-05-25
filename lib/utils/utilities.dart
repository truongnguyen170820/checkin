import 'dart:io';
import 'dart:typed_data';

import 'package:checkin/model/common/date_ranger_filter.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:progress_dialog/progress_dialog.dart';

class Utilites {
  static String formatNumber({dynamic number, String format = "#0.00"}) {
    return new NumberFormat(format).format(number);
  }

  static String formatMoney(dynamic number, {String suffix = "VND"}) {
    final oCcy = new NumberFormat("#,##0", "vi_VN");
    return oCcy.format(number) + ' ' + suffix;
  }

  static showToast(BuildContext context, String mess,
      {Color textColor = Colors.white}) {
    FlutterToast(context).showToast(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: ColorUtils.BLACK_BACKGROUND,
          ),
          child: Text(
            mess,
            style: FontUtils.NORMAL.copyWith(color: textColor),
          )),
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 2),
    );
  }

  static const DATE_FORMAT = 'yyyy/M/d';
  static String formattedDate(DateTime dateTime) {
    print('dateTime ($dateTime)');
    return DateFormat(DATE_FORMAT).format(dateTime);
  }

  static String getAcronym(String text) {
    text = text.trim();
    if (text == null || text.isEmpty) return "";
    var words = text.split(' ');
    if (words.length == 1) {
      if (words[0].length == 1) return words[0];
      return words[0].substring(0, 2);
    }
    var first = words.first;
    var last = words.last;
    return first.substring(0, 1) + last.substring(0, 1);
  }
  // showToastLostInternet(BuildContext context){
  //   FlutterToast(context).showToast(child: Container(
  //     width: setWidth(188),
  //     height: setWidth(188),
  //     padding: EdgeInsets.fromLTRB(setWidth(30),setWidth(20),setWidth(30),setWidth(30)),
  //     decoration: BoxDecoration(
  //         borderRadius:BorderRadius.circular(setWidth(19)),
  //         color: ColorUtils.BLACK_BACKGROUND
  //     ) ,
  //     child: Column(
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: setWidth(40),
  //           backgroundColor: ColorUtils.RED_BACKGROUND,
  //           child: Icon(
  //             Icons.signal_wifi_off,
  //             color: Colors.white,
  //             size: setWidth(30),
  //           ),
  //         ),
  //         WidgetSpacer(height:setWidth(5)),
  //         Text("Không có kết nối internet",textAlign: TextAlign.center,
  //           style: FontUtils.NORMAL.copyWith(fontSize: setSp(16),color: Colors.white),)
  //       ],
  //     ),
  //   ),gravity: ToastGravity.CENTER);
  // }

  // showToastGetLocationFail(BuildContext context){
  //   FlutterToast(context).showToast(child: Container(
  //     width: setWidth(200),
  //     height: setWidth(200),
  //     padding: EdgeInsets.fromLTRB(setWidth(30),setWidth(20),setWidth(30),setWidth(30)),
  //     decoration: BoxDecoration(
  //         borderRadius:BorderRadius.circular(setWidth(19)),
  //         color: ColorUtils.BLACK_BACKGROUND
  //     ) ,
  //     child: Column(
  //       children: <Widget>[
  //         CircleAvatar(
  //           radius: setWidth(40),
  //           backgroundColor: ColorUtils.RED_BACKGROUND,
  //           child: Icon(
  //             Icons.location_off,
  //             color: Colors.white,
  //             size: setWidth(30),
  //           ),
  //         ),
  //         WidgetSpacer(height:setWidth(5)),
  //         Text("Không tìm được vị trí của bạn",textAlign: TextAlign.center,
  //           style: FontUtils.NORMAL.copyWith(fontSize: setSp(16),color: Colors.white),)
  //       ],
  //     ),
  //   ),gravity: ToastGravity.CENTER);
  // }

  static isEmptyIdStr(String idstr) {
    return idstr == null ||
        idstr.isEmpty ||
        idstr == "000000000000000000000000";
  }

  static String currencyFormatterWithoutSuffix(num amount) {
    if (amount == null) return null;
    NumberFormat formatter = NumberFormat('###,###');
    return formatter.format(amount);
  }

  static String dateToString(DateTime vdate, {String format: "dd/MM/yyyy"}) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(vdate);
  }

  static Future<Uint8List> compress(String path, int quanlity) async {
    Uint8List result;
    try {
      result = await FlutterImageCompress.compressWithFile(path,
          quality: quanlity, keepExif: false);
      print("Compress ${path} size after compress ${result.length}");
    } on Exception catch (e) {
      print(e);
    }
    return result;
  }

  static getQuantity(String path) async {
    var file = File(path);
    if (file != null) {
      var length = await file.length();
      print("Compress ${path} size before compress ${length}");
      if (length < 100000) {
        return 90;
      } else if (length < 500000) {
        return 80;
      } else if (length < 1000000) {
        return 70;
      } else if (length < 2000000) {
        return 60;
      } else
        return 50;
    }
    return 100;
  }
  static List<DateRangerModel> getListFilteredDate() {
    var result = List<DateRangerModel>();
    var currentDay = DateTime.now();
    result.add(DateRangerModel(
        "Hôm nay",
        DateTime(currentDay.year, currentDay.month, currentDay.day),
        DateTime(currentDay.year, currentDay.month, currentDay.day),
        0));
    var pastDay = currentDay.subtract(Duration(days: 1));
    result.add(DateRangerModel(
        "Hôm qua",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        1));
    pastDay = currentDay.subtract(Duration(days: currentDay.weekday - 1));
    var recentDay = currentDay.add(Duration(days: 7 - currentDay.weekday));
    result.add(DateRangerModel(
        "Tuần này",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(recentDay.year, recentDay.month, recentDay.day),
        2));

    pastDay = currentDay.subtract(Duration(days: currentDay.weekday + 6));
    recentDay = currentDay.subtract(Duration(days: currentDay.weekday));
    result.add(DateRangerModel(
        "Tuần trước",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(recentDay.year, recentDay.month, recentDay.day),
        3));

    pastDay = currentDay.subtract(Duration(days: currentDay.day - 1));
    recentDay = DateTime(pastDay.year, pastDay.month + 1, 1)
        .subtract(Duration(days: 1));
    result.add(DateRangerModel(
        "Tháng này",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(currentDay.year, currentDay.month, currentDay.day),
        4));

    pastDay = DateTime(currentDay.year, currentDay.month - 1, 1);
    recentDay = DateTime(pastDay.year, pastDay.month + 1, 1)
        .subtract(Duration(days: 1));
    result.add(DateRangerModel(
        "Tháng trước",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(pastDay.year, pastDay.month+1, 0),
        5));
    pastDay = currentDay.subtract(Duration(days: 1));
    result.add(DateRangerModel(
        "Tùy chọn",
        DateTime(pastDay.year, pastDay.month, pastDay.day),
        DateTime(currentDay.year, currentDay.month, currentDay.day),
        6));
    return result;
  }

  static ProgressDialog getProgressDialog(BuildContext context,
      {String message = "Vui lòng chờ..."}) {
    final dialog = ProgressDialog(context);
    dialog.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    return dialog;
  }
}
