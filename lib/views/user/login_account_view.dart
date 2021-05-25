import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/blocs/manage_token_bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/views/user/register_account_view.dart';
import 'package:checkin/views/user/require_otp_view.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/blocs/authen_bloc.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/views/main/home_page_view.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as passwordStore;

import '../../main.dart';

class LoginAccountView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => LoginAccountViewState();
}

class LoginAccountViewState extends State<LoginAccountView>
    with ApiResultListener {
  final storage = passwordStore.FlutterSecureStorage();
  final loginBloc = LoginBloc();
  final _accountController = TextEditingController();
  final _passController = TextEditingController();
  final _domainController = TextEditingController();
  bool _isRememberMe = false;
  bool _isShowPassword = true;

  @override
  void initState() {
    super.initState();
    loginBloc.onLoginAccountListen(this);
    storage.read(key: AppConstants.KEY_USER_NAME).then((value) {
      setState(() {
        if (value != null && value.isNotEmpty) _isRememberMe = true;
        _accountController.text = value;
      });
    });
    storage.read(key: AppConstants.KEY_PASSWORD).then((value) {
      setState(() {
        _passController.text = value;
      });
    });
    storage.read(key: AppConstants.KEY_DOMAIN).then((value) {
      setState(() {
        _domainController.text = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(
                left: setWidth(8), right: setWidth(8), bottom: setHeight(9)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: setHeight(40),
                ),
                GlobalCache().loginData != null
                    ? Container(
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: ApiConstants().getFullImage(GlobalCache().loginData.domainLogo),
                              fit: BoxFit.cover,
                              width: setWidth(124),
                              height: setWidth(124),
                            ),
                            SizedBox(
                              height: setHeight(12),
                            ),
                            Text(
                              GlobalCache().loginData.companyName?.toUpperCase() ?? "",
                              style:
                                  FontUtils.BOLD.copyWith(fontSize: setSp(18)),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              width: setWidth(124),
                              height: setWidth(124),
                            ),
                            SizedBox(height: setHeight(8),),
                            Text(
                              "ỨNG DỤNG PHÒNG CHỐNG COVID-19",
                              style:
                                  FontUtils.SEMIBOLD.copyWith(fontSize: setSp(18)),
                            ),
                          ],
                        ),
                      ),
                widgetLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget widgetLogin() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(setWidth(24), 0, setWidth(24), 0),
          height: setHeight(543),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(setWidth(14)),
              color: ColorUtils.WHITE),
          child: Column(
            children: [
              SizedBox(
                height: setHeight(40),
              ),
              // Nhập tài khoản
              Container(
                margin: EdgeInsets.only(bottom: setHeight(18)),
                height: setHeight(45),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: setSp(13)),
                  controller: _accountController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Nhập tên tài khoản',
                    hintStyle: TextStyles.hint,
                    prefixIcon: Container(
                        margin: EdgeInsets.all(9),
                        child: Image.asset(getAssetsIcon('ic_acount.png'))),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              // Nhập mật khẩu
              Container(
                margin: EdgeInsets.only(bottom: setHeight(18)),
                height: setHeight(45),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(fontSize: setSp(13)),
                  controller: _passController,
                  obscureText: _isShowPassword,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    // Icon(
                    //                       Icons.key,
                    //                       size: 22,
                    //                     )
                    prefixIcon: Container(
                        margin: EdgeInsets.all(9),
                        child: Image.asset(getAssetsIcon('ic_pass.png'))),
                    hintText: 'Nhập mật khẩu',
                    hintStyle: TextStyles.hint,
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
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),
              // Nhập mã công ty
              Container(
                height: setHeight(45),
                margin: EdgeInsets.only(bottom: setHeight(5)),
                child: TextField(
                  textAlignVertical: TextAlignVertical.bottom,
                  style: TextStyle(fontSize: setSp(13)),
                  controller: _domainController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Container(
                        margin: EdgeInsets.all(9),
                        child: Image.asset(getAssetsIcon('ic_domain.png'))),
                    hintText: 'Nhập tên miền',
                    hintStyle: TextStyles.hint,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue, width: 2.0),
                    ),
                  ),
                ),
              ),
              // Checkbok
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Checkbox(
                    value: _isRememberMe,
                    activeColor: ColorUtils.MAIN_GRADIENT_1,
                    checkColor: Colors.white,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isRememberMe = newValue;
                      });
                    },
                  ),
                  Text(
                    'Lưu mật khẩu',
                    style: TextStyles.common_text,
                  ),
                ],
              ),
              // Container(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       ,
              //       TextButton(onPressed: null, child: Text('Quên mật khẩu?', style: FontUtils.NORMAL.,))
              //       GestureDetector(
              //         behavior: HitTestBehavior.translucent,
              //         child: Text(
              //           'Quên mật khẩu?',
              //           style: TextStyles.common_text
              //               .copyWith(color: Colors.blue),
              //         ),
              //         onTap: () {
              //           Navigator.push(
              //               context,
              //               MaterialPageRoute(
              //                   builder: (context) => ForgotPasswordView()));
              //         },
              //       ),
              //     ],
              //   ),
              // ),
              SizedBox(
                height: setHeight(23),
              ),
              // Button đăng nhập
              Center(
                child: CustomButton(
                  height: setHeight(42),
                  width: setWidth(200),
                  borderRadius: setWidth(12),
                  bgColor: ColorUtils.MAIN_GRADIENT_1,
                  title: "Đăng nhập",
                  onTap: loginAccount,
                ),
              ),
              SizedBox(
                height: setHeight(30),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordView()));
                        },
                        child: Text(
                          'Quên mật khẩu?',
                          style: FontUtils.NORMAL
                              .copyWith(color: ColorUtils.MAIN_GRADIENT_1),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterAccountView()));
                        },
                        child: Text(
                          'Chưa có tài khoản?',
                          style: FontUtils.NORMAL
                              .copyWith(color: ColorUtils.MAIN_GRADIENT_1),
                        )),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void loginAccount() async {
    if (_accountController.text == null || _accountController.text == '') {
      Utilites.showToast(context, 'Bạn chưa nhập tài khoản');
      return;
    }
    if (_passController.text == null || _passController.text == '') {
      Utilites.showToast(context, 'Bạn chưa nhập mật khẩu');
      return;
    }
    if (_domainController.text == null || _domainController.text == '') {
      Utilites.showToast(context, 'Bạn chưa nhập tên miền');
      return;
    }
    loginBloc.loginAccount(
        userName: _accountController.text.trim(),
        passWord: _passController.text,
        domainName: _domainController.text.trim());
  }

  @override
  void dispose() {
    loginBloc.dispose();
    _passController.dispose();
    _accountController.dispose();
    _domainController.dispose();
    super.dispose();
  }

  @override
  void onError(String message) async {
    pop(context);
    Utilites.showToast(context, message);
  }

  @override
  void onRequesting() {
    showLoading(context);
  }

  @override
  void onSuccess(List response) async {
    pop(context);
    if (_isRememberMe) {
      storage.write(
          key: AppConstants.KEY_USER_NAME, value: _accountController.text);
      storage.write(
          key: AppConstants.KEY_PASSWORD, value: _passController.text);
      storage.write(
          key: AppConstants.KEY_DOMAIN, value: _domainController.text);
    }
    firebaseMessaging.getToken().then((String token) async {
      if (token != null) {
        print("token:"+token);
        final updateTokenBloc = ManageTokenBloc();
        await updateTokenBloc.init();
        updateTokenBloc.checkTokenSaved(token, Platform.isAndroid ? 0 : 1);
      }
    });
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => HomePageView()),
        (route) => false);
  }
}
