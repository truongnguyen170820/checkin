import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui show window;

class Screen {
  static MediaQueryData mediaQuery = MediaQueryData.fromWindow(ui.window);

  static double get width {
    return mediaQuery.size.width;
  }

  static double get height {
    return mediaQuery.size.height;
  }

  static double get scale {
    return mediaQuery.devicePixelRatio;
  }

  static double get topSafeHeight {
    return mediaQuery.padding.top;
  }

  static double get bottomSafeHeight {
    return mediaQuery.padding.bottom;
  }

  static double get deviceHeight {
    return mediaQuery.padding.bottom +
        mediaQuery.size.height +
        mediaQuery.padding.top;
  }

  static updateStatusBarStyle(SystemUiOverlayStyle style) {
    SystemChrome.setSystemUIOverlayStyle(style);
  }

  static double get appBarHeight {
    AppBar appBar = AppBar(
      title: Text('Demo'),
    );
    return appBar.preferredSize.height;
  }
}
