import 'package:checkin/widget/toast.dart';
import 'package:flutter/cupertino.dart';

showMessage(BuildContext context, String message,
    {int gravity = 0, Color color,int duration=3}) {
  Toast.show(message, context, gravity: Toast.BOTTOM, duration: duration);
}