import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/widget/global.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

ProgressDialog progDialog(BuildContext context,{String message = "Đang tải..."}) {
  ProgressDialog progressDialog = ProgressDialog(context, isDismissible: false);
  progressDialog.style(
    message: message,
    messageTextStyle: TextStyles.progress_text,
    backgroundColor: ColorUtils.backgroundColor,
    progressWidget: Container(
      padding: EdgeInsets.all(setWidth(8)),
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(Colors.blue),
      ),
    ),
  );
  return progressDialog;
}