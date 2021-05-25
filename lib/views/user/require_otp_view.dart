import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/utils/validator_utils.dart';
import 'package:checkin/views/user/reset_password_view.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ForgotPasswordView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView>
    implements ApiResultListener {
  // CheckOtpBloc checkOtpBloc = CheckOtpBloc();
  TextEditingController _txtPhoneNumber = TextEditingController();
  TextEditingController _txtOtp = TextEditingController();
  // ProgressDialog progressDialog;
  FirebaseAuth auth;
  String verifyId;
  bool isOtpSent = false;
  SharedPreferences prefs;

  Future init() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    super.initState();
    // progressDialog = progDialog(context, message: "Đang xử lý...");
    // checkOtpBloc.init(this);
    // checkOtpBloc.checkOtp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Xác minh số điện thoại'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(setWidth(16)),
            height: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: setHeight(40),
                ),
                isOtpSent
                    ? Center(
                        child: Text(
                            'Vui lòng kiểm tra tin nhắn\ntìm và nhập mã OTP',
                            textAlign: TextAlign.center,
                            style: FontUtils.SEMIBOLD
                                .copyWith(fontSize: setSp(14))),
                      )
                    : Text(
                        'Nhập số điện thoại của bạn',
                        textAlign: TextAlign.center,
                        style: FontUtils.SEMIBOLD.copyWith(fontSize: setSp(14)),
                      ),
                SizedBox(
                  height: setHeight(16),
                ),
                isOtpSent
                    ? Container(
                        height: setHeight(45),
                        child: TextField(
                          controller: _txtOtp,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Nhập mã OTP',
                            hintStyle: FontUtils.NORMAL
                                .copyWith(color: ColorUtils.color_hintText),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: setHeight(45),
                        child: TextField(
                          controller: _txtPhoneNumber,
                          textAlign: TextAlign.start,
                          textAlignVertical: TextAlignVertical.bottom,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Nhập số điện thoại',
                            hintStyle: FontUtils.NORMAL
                                .copyWith(color: ColorUtils.color_hintText),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  height: setHeight(60),
                ),
                isOtpSent
                    ? Center(
                        child: CustomButton(
                          title: 'Tiếp tục',
                          onTap: sendOtp,
                          width: setWidth(200),
                        ),
                      )
                    : Center(
                        child: CustomButton(
                          title: 'Tiếp tục',
                          onTap: requireOtp,
                          width: setWidth(200),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future authenListen(String phone, BuildContext context) {
    auth = FirebaseAuth.instance;
    try {
      auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {
          // progressDialog.hide();
          // Auto-resolution timed out...
        },
        verificationCompleted: (PhoneAuthCredential credential) async {
          // progressDialog.hide();
          pop(context);
          UserCredential result = await auth.signInWithCredential(credential);
          User user = result.user;
          if (user != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ResetPasswordView(user.phoneNumber)));
          } else {
            print("Lỗi khi tự động xác nhận OTP");
          }
          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (FirebaseAuthException exception) {
          // progressDialog.hide();
          pop(context);
          print(exception);
          if (exception.code == 'invalid-phone-number') {
            Utilites.showToast(context, "Số điện thoại không hợp lệ");
          } else {
            Utilites.showToast(context, "Có lỗi xảy ra, hãy thử lại sau");
          }
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          // progressDialog.hide();
          pop(context);
          setState(() {
            isOtpSent = true;
            verifyId = verificationId;
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      // progressDialog.hide();
      pop(context);
      print("Error: ${e.code}");
      Utilites.showToast(context, "Có lỗi xảy ra");
    }
  }

  void requireOtp() async {
    FocusScope.of(context).unfocus();
    if (_txtPhoneNumber.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập số điện thoại');
      return;
    }
    if (!Validator.instance.IsPhoneNumber(_txtPhoneNumber.text)) {
      Utilites.showToast(context, 'Số điện thoại không hợp lệ');
      return;
    }

    prefs = await SharedPreferences.getInstance();
    String currentDate = DateTime.now().toString().substring(0, 10);
    // print(currentDate);
    int requireCounter = prefs.getInt(currentDate);
    // print(requireCounter);
    if (requireCounter == null || requireCounter < 3) {
      showLoading(context);
      // progressDialog.show();
      // print("hello");
      authenListen(
          '+84' + _txtPhoneNumber.text.trim().substring(1, 10), context);
      prefs.setInt(currentDate, (requireCounter ?? 0) + 1);
    } else {
      Utilites.showToast(context, "Bạn đã yêu cầu OTP quá 3 lần/ngày");
    }
  }

  void sendOtp() async {
    UserCredential result;
    FocusScope.of(context).unfocus();
    if (_txtOtp.text == null || _txtOtp.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập mã OTP');
      return;
    }
    showLoading(context);
    // progressDialog.show();
    String code = _txtOtp.text.trim();
    try {
      AuthCredential credential =
          PhoneAuthProvider.credential(verificationId: verifyId, smsCode: code);
      result = await auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      // progressDialog.hide();
      pop(context);
      print("Error: ${e.code}");
      Utilites.showToast(
          context, "Mã OTP không đúng hoặc quá hạn, hãy thử lại");
    }
    if (result != null) {
      User user = result.user;
      if (user != null) {
        pop(context);
        // progressDialog.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordView(user.phoneNumber)));
      } else {
        // progressDialog.hide();
        pop(context);
        Utilites.showToast(context, "Có lỗi xảy ra, hãy thử lại");
        print("Lỗi user không đúng");
      }
    } else {
      // progressDialog.hide();
      pop(context);
      Utilites.showToast(context, "Có lỗi xảy ra, hãy thử lại");
      print("Lỗi khi xác nhận OTP");
    }
  }

  @override
  void onError(String message) {}

  @override
  void onRequesting() {}

  @override
  void onSuccess(List response) {}
}
