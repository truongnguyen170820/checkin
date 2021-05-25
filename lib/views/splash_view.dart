import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/screen/screen_utils.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        height: 667, width: 375, allowFontScaling: true);
    return Scaffold(
      body: Container(
        color: ColorUtils.MAIN_GRADIENT_1,
        child: Padding(
          padding: const EdgeInsets.only(left: 90, right: 90,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                "assets/images/logo.png"
              ),
            ],
          ),
        ),
      ),
    );
  }
}