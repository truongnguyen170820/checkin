import 'package:checkin/blocs/user/change_pwd_user_bloc.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/views/user/login_account_view.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/widget/common_appbar.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ChangePasswordViewState();
}

class ChangePasswordViewState extends State<ChangePasswordView>
    with ApiResultListener {
  TextEditingController _txtOldPwd = TextEditingController();
  TextEditingController _txtNewPwd = TextEditingController();
  TextEditingController _txtRepeatPwd = TextEditingController();
  ChangePwdUserBloc changePwdUserBloc = ChangePwdUserBloc();

  @override
  void initState() {
    super.initState();

    changePwdUserBloc.onChangePwdListen(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Thay đổi mật khẩu'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Mật khẩu hiện tại',
                    style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    height: setHeight(42),
                    child: TextField(
                      controller: _txtOldPwd,
                      style: TextStyles.common_black,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*******',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Text('Mật khẩu mới',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(13))),
                  SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    height: setHeight(42),
                    child: TextField(
                      controller: _txtNewPwd,
                      style: TextStyles.common_black,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*******',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 20,
                  ),
                  Text('Nhập lại mật khẩu',
                      style: FontUtils.NORMAL.copyWith(fontSize: setSp(13))),
                  SizedBox(
                    width: double.infinity,
                    height: 10,
                  ),
                  Container(
                    height: setHeight(42),
                    child: TextField(
                      controller: _txtRepeatPwd,
                      style: TextStyles.common_black,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '*******',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          // borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                  ),
                  Center(
                    child: CustomButton(
                      title: 'Xác nhận',
                      onTap: changePwd,
                      height: setHeight(45),
                      width: setWidth(200),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void changePwd() {
    FocusScope.of(context).unfocus();
    if (_txtOldPwd.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập thông tin mật khẩu hiện tại');
      return;
    }
    if (_txtNewPwd.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập thông tin mật khẩu mới');
      return;
    }
    if (_txtRepeatPwd.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập thông tin mật khẩu nhập lại');
      return;
    }
    if (_txtNewPwd.text != _txtRepeatPwd.text) {
      Utilites.showToast(
          context, 'Mật khẩu mới và Mật khẩu nhập lại không giống nhau');
      return;
    }
    if (_txtNewPwd.text.length < 6) {
      Utilites.showToast(context, 'Độ dài mật khẩu cần lớn hơn 5 ký tự');
      return;
    }
    if (_txtOldPwd.text == _txtNewPwd.text) {
      Utilites.showToast(context, 'Mật khẩu mới bị trùng mật khẩu hiện tại');
      return;
    }
    changePwdUserBloc.executeChangePwd(_txtOldPwd.text, _txtNewPwd.text);
  }

  @override
  void onRequesting() {
    showLoading(context);
  }

  @override
  void onSuccess(List<dynamic> response) {
    pop(context);
    showMessage(context, 'Đổi mật khẩu thành công');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginAccountView()),
        (route) => false);
  }

  @override
  void onError(String message) async {
    pop(context);
    showMessage(context, message);
  }

  @override
  void dispose() {
    changePwdUserBloc.dispose();
    _txtNewPwd.dispose();
    _txtOldPwd.dispose();
    _txtRepeatPwd.dispose();
    super.dispose();
  }
}
