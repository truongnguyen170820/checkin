// import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
// import 'package:checkin/blocs/user/update_profile_bloc.dart';
// import 'package:checkin/utils/TextStyles.dart';
// import 'package:checkin/utils/color_utils.dart';
// import 'package:checkin/utils/utilities.dart';
// import 'package:checkin/utils/validator_utils.dart';
// import 'package:checkin/widget/common_appbar.dart';
// import 'package:checkin/widget/custom_button.dart';
// import 'package:checkin/widget/global.dart';
// import 'package:checkin/utils/global_cache.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:progress_dialog/progress_dialog.dart';
//
// class UpdateProfileView extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() => UpdateProfileViewState();
// }
//
// class UpdateProfileViewState extends State<UpdateProfileView>
//     with ApiResultListener {
//   UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
//   ProgressDialog progressDialog;
//   String _radioValue;
//
//   TextEditingController _txtName = TextEditingController();
//   TextEditingController _txtEmail = TextEditingController();
//   TextEditingController _txtBirthdayStr = TextEditingController();
//   TextEditingController _txtAddress = TextEditingController();
//   TextEditingController _txtMomoMobile = TextEditingController();
//   TextEditingController _txtMomoName = TextEditingController();
//   DateTime selectedDate = DateTime.now();
//
//   @override
//   void initState() {
//     super.initState();
//     var userInfo = GlobalCache().loginData;
//     // _txtName.text = userInfo.fullName;
//     // _txtEmail.text = userInfo.email;
//     // _txtBirthdayStr.text = userInfo.birthday;
//     // _txtAddress.text = userInfo.address;
//     // _txtMomoMobile.text = userInfo.momoMobile;
//     // _txtMomoName.text = userInfo.momoName;
//     progressDialog = ProgressDialog(context);
//     progressDialog.style(
//       message: 'Cập nhật...',
//       messageTextStyle: TextStyles.progress_text,
//       backgroundColor: ColorUtils.backgroundColor,
//       progressWidget: Container(
//         padding: EdgeInsets.all(setWidth(8)),
//         child: CircularProgressIndicator(
//           valueColor: AlwaysStoppedAnimation(ColorUtils.MAIN_GRADIENT_1),
//         ),
//       ),
//     );
//     updateProfileBloc.onUpdateProfileListen(this);
//     // if (userInfo.gender == null || userInfo.gender.isEmpty)
//     //   _radioValue = "Nam";
//     // else
//     //   _radioValue = userInfo.gender;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: backAppBar(context, 'Cập nhật thông tin'),
//       body: SafeArea(
//         child: GestureDetector(
//           onTap: (){
//             FocusScope.of(context).requestFocus(FocusNode());
//           },
//           child: SingleChildScrollView(
//             child: Container(
//               padding: EdgeInsets.all(setWidth(20)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(0)),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'Họ và tên',
//                           style: TextStyles.common_text,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.red,
//                           size: setWidth(10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   TextField(
//                     controller: _txtName,
//                     style: TextStyles.common_black,
//                     textAlign: TextAlign.start,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập họ và tên tại đây',
//                       hintStyle: TextStyles.hint,
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(20)),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'Địa chỉ',
//                           style: TextStyles.common_text,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.red,
//                           size: setWidth(10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   TextField(
//                     controller: _txtAddress,
//                     style: TextStyles.common_black,
//                     textAlign: TextAlign.start,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập địa chỉ tại đây',
//                       hintStyle: TextStyles.hint,
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                       ),
//                     ),
//                   ),
//                   Container(
//                       margin: EdgeInsets.only(top: setWidth(20)),
//                       child: Row(
//                         children: <Widget>[
//                           Text('Giới tính', style: TextStyles.common_text),
//                           Icon(
//                             Icons.star,
//                             color: Colors.red,
//                             size: setWidth(10),
//                           ),
//                           // Expanded(
//                           //   child: Container(
//                           //     alignment: Alignment.centerRight,
//                           //     child: Radio(
//                           //         activeColor: ColorUtils.MAIN_GRADIENT_1,
//                           //         value: 'Nam',
//                           //         groupValue: _radioValue,
//                           //         onChanged: radioButtonChanges),
//                           //   ),
//                           // ),
//                           // Text('Nam', style: TextStyles.common_black),
//                           // Radio(
//                           //     activeColor: ColorUtils.MAIN_GRADIENT_1,
//                           //     value: 'Nữ',
//                           //     groupValue: _radioValue,
//                           //     onChanged: radioButtonChanges),
//                           Text('Nữ', style: TextStyles.common_black)
//                         ],
//                       )),
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(20)),
//                     child: Text(
//                       'Ngày sinh',
//                       style: TextStyles.common_text,
//                     ),
//                   ),
//                   Stack(
//                     alignment: AlignmentDirectional.bottomEnd,
//                     children: <Widget>[
//                       TextField(
//                         controller: _txtBirthdayStr,
//                         style: TextStyles.common_black,
//                         textAlign: TextAlign.start,
//                         textAlignVertical: TextAlignVertical.bottom,
//                         keyboardType: TextInputType.datetime,
//                         decoration: InputDecoration(
//                           hintText: 'dd/mm/yyyy',
//                           hintStyle: TextStyles.hint,
//                           enabledBorder: UnderlineInputBorder(
//                             borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: Icon(Icons.date_range),
//                         iconSize: 32,
//                         color: Colors.grey,
//                         onPressed: () {
//                           // _selectDate(context, _txtBirthdayStr);
//                         },
//                       )
//                     ],
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(20)),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'Email',
//                           style: TextStyles.common_text,
//                         ),
//                         Icon(
//                           Icons.star,
//                           color: Colors.red,
//                           size: setWidth(10),
//                         ),
//                       ],
//                     ),
//                   ),
//                   TextField(
//                     controller: _txtEmail,
//                     style: TextStyles.common_black,
//                     textAlign: TextAlign.start,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập địa chỉ email tại đây',
//                       hintStyle: TextStyles.hint,
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(20)),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'Số điện thoại Momo',
//                           style: TextStyles.common_text,
//                         ),
//                       ],
//                     ),
//                   ),
//                   TextField(
//                     controller: _txtMomoMobile,
//                     style: TextStyles.common_black,
//                     textAlign: TextAlign.start,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     keyboardType: TextInputType.number,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập số điện thoại Momo',
//                       hintStyle: TextStyles.hint,
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(top: setWidth(20)),
//                     child: Row(
//                       children: <Widget>[
//                         Text(
//                           'Tên tài khoản Momo',
//                           style: TextStyles.common_text,
//                         ),
//                       ],
//                     ),
//                   ),
//                   TextField(
//                     controller: _txtMomoName,
//                     style: TextStyles.common_black,
//                     textAlign: TextAlign.start,
//                     textAlignVertical: TextAlignVertical.bottom,
//                     keyboardType: TextInputType.name,
//                     decoration: InputDecoration(
//                       hintText: 'Nhập tên Momo',
//                       hintStyle: TextStyles.hint,
//                       enabledBorder: UnderlineInputBorder(
//                         borderSide: BorderSide(color: ColorUtils.MAIN_GRADIENT_1),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: setHeight(30),
//                   ),
//                   Center(
//                     child: CustomButton(title:'Cập nhật', onTap:updateProfile),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void updateProfile() {
//     FocusScope.of(context).requestFocus(FocusNode());
//     if (_txtName.text.trim().isEmpty) {
//       Utilites.showToast(context, 'Bạn chưa nhập họ và tên');
//       return;
//     }
//     if (_txtAddress.text.trim().isEmpty) {
//       Utilites.showToast(context, 'Bạn chưa nhập địa chỉ');
//       return;
//     }
//     if (_txtEmail.text.isEmpty) {
//       Utilites.showToast(context, 'Bạn chưa nhập email');
//       return;
//     }
//     if (!Validator.instance.IsEmail(_txtEmail.text)) {
//       Utilites.showToast(context, 'Email không hợp lệ');
//       return;
//     }
//   //   progressDialog.show().whenComplete(() => updateProfileBloc.onUpdateProfile(
//   //       _txtName.text,
//   //       _txtAddress.text,
//   //       _radioValue,
//   //       _txtBirthdayStr.text ?? '',
//   //       _txtEmail.text,
//   //       _txtMomoMobile.text,
//   //       _txtMomoName.text));
//   // }
//
//   @override
//   void onRequesting() async {
//     await progressDialog.show();
//     return;
//   }
//
//   @override
//   void onSuccess(List<dynamic> response) async {
//     await progressDialog.hide();
//     Navigator.pop(context);
//     Utilites.showToast(context, 'Cập nhật thành công');
//   }
//
//   @override
//   void onError(String message) async {
//     await progressDialog.hide();
//     Utilites.showToast(context, message);
//   }
//
//   void radioButtonChanges(String value) {
//     setState(() {
//       _radioValue = value;
//     });
//   }
//
//   Future<Null> _selectDate(
//       BuildContext context, TextEditingController txtController) async {
//     final DateTime picked = await showDatePicker(
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1970, 8),
//         lastDate: DateTime(2101));
//     if (picked != null &&
//         DateFormat('dd/MM/yyyy').format(picked) != txtController.text)
//       setState(() {
//         // selectedDate = picked;
//         txtController.text = DateFormat('dd/MM/yyyy').format(picked);
//       });
//   }
//
//   @override
//   void dispose() {
//     updateProfileBloc.dispose();
//     _txtBirthdayStr.dispose();
//     _txtEmail.dispose();
//     _txtAddress.dispose();
//     _txtName.dispose();
//     super.dispose();
//   }
// }
//
//   @override
//   void onError(String message) {
//     // TODO: implement onError
//   }
//
//   @override
//   void onRequesting() {
//     // TODO: implement onRequesting
//   }
//
//   @override
//   void onSuccess(List response) {
//     // TODO: implement onSuccess
//   }
