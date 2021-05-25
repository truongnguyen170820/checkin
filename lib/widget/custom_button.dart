import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'global.dart';

class CustomButton extends StatelessWidget {
  String title;
  TextStyle textStyle;
  double borderRadius;
  Color bgColor;
  EdgeInsets margin;
  Function onTap;
  double width;
  double height;
  Color colorShadow;
  Color colorBorder;

  CustomButton(
      {this.bgColor = ColorUtils.MAIN_GRADIENT_1,
      this.onTap,
      this.title,
      this.borderRadius = 12,
      this.textStyle,
      this.margin,
      this.width = double.infinity,
      this.height = 45,
      this.colorShadow,
        this.colorBorder,
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: EdgeInsets.symmetric(horizontal: 5),
        width: width, height: height,
        alignment: Alignment.center,
        // padding:  EdgeInsets.only(left:setWidth(20), top:setHeight(15), right:setWidth(20), bottom: setHeight(15)),
        decoration: BoxDecoration(
          border: colorBorder==null ? null : Border.all(color: colorBorder, width: setWidth(1)),
            color: bgColor, borderRadius: BorderRadius.circular(borderRadius),boxShadow: colorShadow == null ? null : [
              BoxShadow(offset: Offset(0,3), blurRadius: 3, color: colorShadow)
        ]),
        child: Text(
          title.toUpperCase(),
          style: FontUtils.MEDIUM.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
