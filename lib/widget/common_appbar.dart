import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/widget/global.dart';
import 'package:flutter/material.dart';

Widget backAppBar(BuildContext context, String title,
    {Function onBack, List<Widget> actions}) {
  if (onBack == null) onBack = () => Navigator.pop(context);
  return AppBar(
    leading: IconButton(
      onPressed: onBack,
      icon: Icon(
        Icons.arrow_back,
        size: 30,
        color: ColorUtils.TEXT_NORMAL,
      ),
    ),
    title: Text(
      title,
      style: FontUtils.SEMIBOLD.copyWith(fontSize: setSp(18)),
    ),
    centerTitle: true,
    actions: actions,
    flexibleSpace: Container(
      decoration: BoxDecoration(color: Colors.white),
    ),
    elevation: 0.0,
  );
}
