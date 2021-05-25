import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:flutter/material.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/blocs/user/reset_password_bloc.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/views/user/login_account_view.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/global.dart';

class ResetPasswordView extends StatefulWidget {
  final String mobile;
  ResetPasswordView(this.mobile);
  @override
  State<StatefulWidget> createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView>
    with ApiResultListener {
  TextEditingController _txtDomain = TextEditingController();
  TextEditingController _txtNewPwd = TextEditingController();
  TextEditingController _txtRepeatPwd = TextEditingController();
  ResetPasswordBloc resetPasswordBloc = ResetPasswordBloc();
  bool _isShowPassword = true;
  bool _isShowRepeatPassword = true;

  @override
  void initState() {
    super.initState();
    resetPasswordBloc.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Đặt lại mật khẩu'),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Tên miền của đơn vị', style: TextStyle(fontSize: setSp(12))),
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                Container(
                  height: setHeight(45),
                  child: TextField(
                    controller: _txtDomain,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    decoration: InputDecoration(
                      hintText: 'Nhập tên miền',
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
                  height: setHeight(20),
                ),
                Text('Mật khẩu mới', style: TextStyle(fontSize: setSp(12))),
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                Container(
                  height: setHeight(45),
                  child: TextField(
                    controller: _txtNewPwd,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: _isShowPassword,
                    decoration: InputDecoration(
                      hintText: '*******',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        // borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
                      ),
                      suffixIcon: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(
                          _isShowPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                          color: ColorUtils.gray6,
                        ),
                        onPressed: () {
                          setState(() {
                            _isShowPassword = !_isShowPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Text('Nhập lại mật khẩu mới',
                    style: TextStyle(fontSize: setSp(12))),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: setHeight(45),
                  child: TextField(
                    controller: _txtRepeatPwd,
                    textAlign: TextAlign.start,
                    textAlignVertical: TextAlignVertical.bottom,
                    obscureText: _isShowRepeatPassword,
                    decoration: InputDecoration(
                      hintText: '*******',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        // borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
                      ),
                      suffixIcon: IconButton(
                        alignment: Alignment.centerLeft,
                        icon: Icon(
                          _isShowRepeatPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          size: 18,
                          color: ColorUtils.gray6,
                        ),
                        onPressed: () {
                          setState(() {
                            _isShowRepeatPassword = !_isShowPassword;
                          });
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(40),
                ),
                Center(
                  child: CustomButton(title:'Đổi mật khẩu', onTap: resetPassword),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void resetPassword() {
    FocusScope.of(context).unfocus();
    if (_txtDomain.text.trim().isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập tên miền đơn vị');
      return;
    }
    if (_txtNewPwd.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập mật khẩu');
      return;
    }
    if (_txtRepeatPwd.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập lại mật khẩu');
      return;
    }
    if (_txtNewPwd.text != _txtRepeatPwd.text) {
      Utilites.showToast(
          context, 'Mật khẩu và Mật khẩu nhập lại không giống nhau');
      return;
    }
    if (_txtNewPwd.text.length < 6) {
      Utilites.showToast(context, 'Độ dài mật khẩu cần lớn hơn 5 ký tự');
      return;
    }
   resetPasswordBloc.resetPassword(
        '0' + widget.mobile.substring(3, 12), _txtNewPwd.text, _txtDomain.text.trim());
  }

  @override
  void onRequesting()  {
   showLoading(context);
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    pop(context);
    Utilites.showToast(context, 'Đổi mật khẩu thành công');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginAccountView()),
        (route) => false);
  }

  @override
  void onError(String message)  {
    pop(context);
    Utilites.showToast(context, message);
  }

  @override
  void dispose() {
    resetPasswordBloc.dispose();
    _txtNewPwd.dispose();
    _txtDomain.dispose();
    _txtRepeatPwd.dispose();
    super.dispose();
  }
}
