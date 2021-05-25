import 'package:checkin/utils/screen/screen_utils.dart';
import 'package:flutter/material.dart';

import 'animation_pushto.dart';

class Global {}

setHeight(num value) {
  return ScreenUtil().setHeight(value);
}

setWidth(num value) {
  return ScreenUtil().setWidth(value);
}

setSp(num value) {
  return ScreenUtil().setSp(value);
}

void dismissKeyboard(BuildContext context) {
  FocusScope.of(context).unfocus();
}

void pop(BuildContext context, {dynamic result}) {
  Navigator.pop(
    context,
    result,
  );
}

void pushReplacementWidget(BuildContext context, Widget widget,
    {String routeName = ""}) {
  if (routeName.isEmpty) routeName = widget.toString();
  Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => widget,
        settings: RouteSettings(
          name: routeName,
        ),
      ));
}

pushTo(BuildContext context, Widget widget, {bool isReturn = false}) async {
  dynamic result;
  if (isReturn)
    result = await Navigator.push(
      context,
      SlideRightRoute(
        page: widget,
      ),
    );
  else
    result = Navigator.push(
      context,
      SlideRightRoute(
        page: widget,
      ),
    );
  return result;
}

String getAssetsIcon(String icon) {
  return "assets/icons/" + icon;
}

String getAssetsIconNotication(String icon) {
  return "assets/icons/notification/" + icon;
}

String getAssetsImage(String image) {
  return "assets/images/" + image;
}
