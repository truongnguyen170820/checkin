import 'package:checkin/blocs/user/register_account_bloc.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/text_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/utils/validator_utils.dart';
import 'package:checkin/views/user/login_account_view.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/widget/common_appbar.dart';

class RegisterAccountView extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => RegisterAccountViewState();
}

class RegisterAccountViewState extends State<RegisterAccountView>
    with ApiResultListener {
  TextEditingController _txtMobile;
  // = TextEditingController();
  TextEditingController _txtName ;
  // = TextEditingController();
  TextEditingController _txtCompanyCode;
  // = TextEditingController();
  TextEditingController _txtPassword ;
  // = TextEditingController();
  TextEditingController _txtRetypePassword;
  // = TextEditingController();
  RegisterAccountBloc registerAccountBloc;
  // = RegisterAccountBloc();;
  ProgressDialog progressDialog;
  bool checkPass;
  bool checkRetypePass;

  @override
  void initState() {
    super.initState();
    checkPass = false;
    checkRetypePass = false;
     _txtMobile = TextEditingController();
     _txtName = TextEditingController();
     _txtCompanyCode = TextEditingController();
     _txtPassword = TextEditingController();
     _txtRetypePassword = TextEditingController();
     registerAccountBloc = RegisterAccountBloc();
    progressDialog = ProgressDialog(context);
    progressDialog.style(
      message: 'Đăng ký tài khoản...',
      messageTextStyle: TextStyles.progress_text,
      backgroundColor: ColorUtils.backgroundColor,
      progressWidget: Container(
        padding: EdgeInsets.all(setWidth(8)),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(ColorUtils.noted_boderColor_regis),
        ),
      ),
    );
    registerAccountBloc.init(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Đăng ký tài khoản'),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: setWidth(16)),color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(height: setHeight(1),width: double.infinity,color: ColorUtils.noted_boderColor_regis,),
                  SizedBox(height: setHeight(16),),
                  // note
                  Container(

                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: setWidth(16), vertical: setHeight(20)),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: ColorUtils.background_editext,
                        borderRadius: BorderRadius.circular(setWidth(12))),
                    child: Text(TextUtils.noted_register, style: FontUtils.NORMAL.copyWith(color: ColorUtils.noted_text_regis, fontSize: setSp(12)),textAlign: TextAlign.center,),
                  ),
                  SizedBox(height: setHeight(15),),
                  itemInfo(title: 'Số điện thoại', hintText: 'Nhập số điện thoại', controller: _txtMobile, type: TextInputType.phone),
                  SizedBox(height: setHeight(16),),
                  itemInfo(title: 'Họ tên', hintText: 'Nhập họ tên', controller: _txtName),
                  SizedBox(height: setHeight(16),),
                  itemInfo(title: 'Tên miền', hintText: 'Nhập mã nhân viên', controller: _txtCompanyCode),
                  SizedBox(height: setHeight(16),),
                  itemInfo(title: 'Mật khẩu của bạn', hintText: 'Nhập mật khẩu', controller: _txtPassword,
                      checkIcon: checkPass,isObs: true,
                      icon: Image.asset('assets/icons/ic_success.png', height: setHeight(12.5), width: setWidth(16.5),fit: BoxFit.cover,),
                      onChanged: (data){
                    print(_txtRetypePassword.text);
                        checkPassword(_txtPassword, _txtRetypePassword);
                      }),
                  SizedBox(height: setHeight(16),),
                  itemInfo(title: 'Nhập lại mật khẩu', hintText: 'Nhập lại mật khẩu', controller: _txtRetypePassword,checkIcon: checkRetypePass,isObs: true,
                      icon: Image.asset('assets/icons/ic_success.png', height: setHeight(12.5), width: setWidth(16.5),fit: BoxFit.cover,),
                  onChanged: (data){
                    print(_txtPassword.text);
                    checkRetypePassword(_txtRetypePassword, _txtPassword);
                  }),
                  SizedBox(height: setHeight(40),),
                  Center(
                    child: CustomButton(height: setHeight(48),width: setWidth(200), bgColor: ColorUtils.MAIN_GRADIENT_1,
                        title:'Đăng ký', onTap:registerAccount),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
    checkPassword(TextEditingController controller, TextEditingController subCtrl) {
      if (subCtrl.text.length == 0 || subCtrl.text == null) {
        if (controller.text.length >= 6) {
          setState(() {
            checkPass = true;
          });
        } else {
          setState(() {
            checkPass = false;
          });
        };
      }
      else {
        if (controller.text.length >= 6) {
          if(controller.text == subCtrl.text){
            setState(() {
              checkPass = true;
              checkRetypePass = true;
            });
          } else {
            setState(() {
              checkPass = true;
              checkRetypePass = false;
            });
          }

        } else {
          setState(() {
            checkPass = false;
          });
        };
      }
    }
  checkRetypePassword(TextEditingController controller,TextEditingController subCtrl){
    if(controller.text == subCtrl.text && controller.text.length >5){
      setState(() {
        checkRetypePass = true;
      });
    } else {
      setState(() {
        checkRetypePass = false;
      });
    };
  }

Widget itemInfo({String title, String hintText, TextEditingController controller,TextInputType type = TextInputType.text,
  Widget icon, bool checkIcon = false, Function onChanged, bool isObs = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: FontUtils.NORMAL.copyWith(fontSize: setSp(13),),),
        SizedBox(height: setHeight(8),),
        Container(
          height: setHeight(45),color: ColorUtils.noted_boderColor_regis.withOpacity(0.1),alignment: Alignment.centerLeft,
          child: TextField(
            keyboardType: type,
            onChanged: onChanged,

            obscureText: isObs,
            controller: controller,
            textAlign: TextAlign.start,
            style: FontUtils.NORMAL.copyWith(color: ColorUtils.text_info),
            textAlignVertical: TextAlignVertical.center,
            enabled: true,
            decoration: InputDecoration(
              // hintText: hintText,
              // prefixIcon: Icon(Icons.event),
              suffix: checkIcon ? icon :SizedBox(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: ColorUtils.text_regis.withOpacity(0.3)),
              ),
            ),
          ),
        )
      ],
    );
}
  bool _isNumeric(String str) {
    if(str == null) {
      return false;
    }
    return num.tryParse(str) != null;
  }
  //2ouf
  // bool _phoneNumberValidator(String value) {
  //   String pattern = r'(^(?:[+0][9|3|8|7|1|5)?[0-9]{10,10}$)';
  //   RegExp regExp = new RegExp(pattern);
  //   if (value.length == 0) {
  //     return  false;
  //   }
  //   else if (!regExp.hasMatch(value)) {
  //     return false;
  //   }
  //   return true;
  // }
  //2ouf
  void registerAccount() async{
    FocusScope.of(context).requestFocus(FocusNode());
    // phone
    if(!Validator().IsPhoneNumber(_txtMobile.text)) {
      Utilites.showToast(context, 'Vui lòng nhập chính xác số điện thoại');
      return;
    }
    // name
    if (_txtName.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập tên');
      return;
    }
    // code Employees
    if (_txtCompanyCode.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập tên miền công ty');
      return;
    }
    // pass
    if (_txtPassword.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập mật khẩu');
      return;
    }
    if (_txtRetypePassword.text.isEmpty) {
      Utilites.showToast(context, 'Bạn chưa nhập lại mật khẩu');
      return;
    }
    if (_txtPassword.text != _txtRetypePassword.text) {
      Utilites.showToast(
          context, 'Mật khẩu và Mật khẩu nhập lại không giống nhau');
      return;
    }
    if (_txtPassword.text.length < 6) {
      Utilites.showToast(context, 'Độ dài mật khẩu cần lớn hơn 6 ký tự');
      return;
    }
    registerAccountBloc.registerAccount(_txtName.text, _txtPassword.text,_txtCompanyCode.text, _txtMobile.text);
    showLoading(context);

  }

  @override
  void onRequesting() async {
    showLoading(context);
    pop(context);
    // await progressDialog.show();
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    pop(context);
    // await progressDialog.hide();
    Utilites.showToast(context, 'Đăng ký tài khoản thành công');
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginAccountView()),
            (route) => false);
  }

  @override
  void onError(String message) async {

    // await progressDialog.hide();
    Utilites.showToast(context, message);
    pop(context);
  }

  @override
  void dispose() {
    registerAccountBloc.dispose();
    _txtMobile.dispose();
    _txtName.dispose();
    _txtCompanyCode.dispose();
    _txtPassword.dispose();
    _txtRetypePassword.dispose();
    super.dispose();
  }
}
