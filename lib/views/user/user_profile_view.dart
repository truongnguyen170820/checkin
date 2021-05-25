import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/blocs/get_region_list_bloc.dart';
import 'package:checkin/blocs/get_struct_info_unit.dart';
import 'package:checkin/blocs/user/get_user_profile_bloc.dart';
import 'package:checkin/blocs/user/update_profile_bloc.dart';
import 'package:checkin/blocs/user/upload_image_bloc.dart';
import 'package:checkin/model/beans/commune_model.dart';
import 'package:checkin/model/beans/country_model.dart';
import 'package:checkin/model/beans/district_model.dart';
import 'package:checkin/model/beans/province_model.dart';
import 'package:checkin/model/beans/user/info_user.dart';
import 'package:checkin/model/beans/user/user_login_model.dart';
import 'package:checkin/utils/app_constant.dart';
import 'package:checkin/utils/app_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/utils/validator_utils.dart';
import 'package:checkin/views/user/update_avatar_view.dart';
import 'package:checkin/widget/circle_avatar.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:heic_to_jpg/heic_to_jpg.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:io';

import 'package:progress_dialog/progress_dialog.dart';

class UserProfileView extends StatefulWidget {
  @override
  _UserProfileViewState createState() => _UserProfileViewState();
}

class _UserProfileViewState extends State<UserProfileView> with ApiResultListener<InfoUser> {
  GetUserProfileBloc bloc = GetUserProfileBloc();
  GetRegionListBloc getRegionListBloc = GetRegionListBloc();
  GetStructInfoListBloc getStructInfoListBloc = GetStructInfoListBloc();

  String _radioValue;
  TextEditingController _txtName = TextEditingController();
  TextEditingController _txtIdCardName = TextEditingController();
  TextEditingController _txtInsuranceCode = TextEditingController();
  TextEditingController _txtBirthDay = TextEditingController();
  TextEditingController _txtCountry = TextEditingController();
  TextEditingController _txtAdressRoad = TextEditingController();
  TextEditingController _txtPhoneNumber = TextEditingController();
  TextEditingController _txtEmailUser = TextEditingController();
  TextEditingController _txtCodeUser = TextEditingController();
  TextEditingController _txtPosition = TextEditingController();
  TextEditingController _txtStructDep = TextEditingController();
  UpdateProfileBloc updateProfileBloc = UpdateProfileBloc();
  TextEditingController _txtTimTinhThanh = TextEditingController();
  TextEditingController _txtTimQuanHuyen = TextEditingController();
  TextEditingController _txtTimXaPhuong = TextEditingController();
  ProgressDialog progressDialog;
  CountryModel countryModel;
  ProvinceModel provinceModel;
  DistrictModel districtModel;
  CommuneModel communeModel;
  UserInfo infoUser;
  @override
  void initState() {
    super.initState();
  infoUser= GlobalCache().loginData.userInfo;
    _txtName.text = infoUser?.profile?.fullName??infoUser.fullName??''; // tên
    _txtIdCardName.text = infoUser?.profile?.identifyNo??''; // cmt
    _txtInsuranceCode.text = infoUser?.profile?.insuranceNo??''; //
    _txtBirthDay.text = infoUser?.profile?.birthdayStr?.substring(0,10)??'';
    _radioValue = infoUser.profile?.gender??'M';
    _txtCountry.text = infoUser.profile?.country??'Việt Nam';
    _txtAdressRoad.text = infoUser.profile?.address??'';
    _txtPhoneNumber.text = infoUser.mobile??infoUser?.mobile??'';
    _txtEmailUser.text = infoUser.email??infoUser.email??'';
    _txtCodeUser.text = infoUser.employeeCode??infoUser.employeeCode??'';
    _txtTimTinhThanh.text = infoUser.profile.provinceName??"";
    _txtTimQuanHuyen.text = infoUser.profile?.districtName??'';
    _txtTimXaPhuong.text = infoUser.profile?.communeName??'';
    _txtPosition.text = infoUser.profile?.positionName??'';
    _txtStructDep.text = infoUser.profile?.structDepName??'';
    bloc.getProfile(context);
    updateProfileBloc.onUpdateProfileListen(this);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: backAppBar(context, 'Tài khoản của tôi'),
      body: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: StreamBuilder(
          stream: bloc.getProfileStream,
          initialData: loadFromCache(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              InfoUser  data = snapshot.data;
              _txtTimXaPhuong.text = data.provinceName;
              if(_txtBirthDay.text == data.birthdayStr || _txtBirthDay.text == null || _txtBirthDay.text.length == 0){
                _txtBirthDay.text = data.birthdayStr??'';
              }
              return Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: ColorUtils.WHITE,
                  padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(width: double.infinity,height: setHeight(1),
                          color: ColorUtils.noted_boderColor_regis,
                          margin: EdgeInsets.only(bottom: setHeight(32)),
                        ),
                        Center(
                          child: Container(
                            height: setWidth(102),width: setWidth(102),
                            margin: EdgeInsets.only(bottom: setHeight(30)),
                            child: Stack(
                              //    GlobalCache().loginData.userInfo.profile.avatarUrl ?? "",
                              //                       GlobalCache().loginData.userInfo.profile.fullName ?? "",
                              children: [
                                circleAvatar(
                                    GlobalCache().loginData.userInfo.profile.avatarUrl ?? "",
                                    GlobalCache().loginData.userInfo.profile.fullName ?? "",
                                    radius: 51),
                                Positioned(
                                    right: 0,bottom: 0,
                                    child: InkWell( child: Image.asset('assets/icons/ic_camera.png', height: setHeight(29),width: setWidth(30),fit: BoxFit.cover),
                                      onTap: () async{
                                        showConfirmDialog();
                                      },))
                              ],
                            ),
                          ),
                        ),
                        itemInfo(title: 'Họ và tên ',subTitle: '*', hintText: 'Nhập họ và tên',controller: _txtName),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Số CMT/CCCD/Hộ chiếu ',subTitle: '*', hintText: 'Nhập số CMT/CCCD/Hộ chiếu',controller: _txtIdCardName),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Mã số BHXH  ', hintText: 'Nhập mã số BHXH',controller: _txtInsuranceCode),
                        SizedBox(height: setHeight(15),),
                        itemInfoDate(title: 'Năm sinh ',subTitle: '*', hintText: 'Nhập ngày tháng năm sinh',
                            controller: _txtBirthDay,isWrite: false,//2ouf
                            icon: IconButton(icon: Icon(Icons.date_range_outlined,color: ColorUtils.gray1 , size: 20,),
                                onPressed: (){
                                  _selectDate(context, _txtBirthDay);
                                })
                        ),
                        SizedBox(height: setHeight(15),),
                        itemRadioBT(title: 'Giới tính', subTitle: '*' ),
                        SizedBox(height: setHeight(5),),
                        Text('Quốc tịch', style: FontUtils.NORMAL,),
                        Container(
                          margin: EdgeInsets.only(
                              top: setHeight(10), bottom: setHeight(10)),
                          child: TypeAheadField(
                            noItemsFoundBuilder: (context) {
                              return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Không tìm thấy kết quả",
                                    style: FontUtils.NORMAL,
                                  ));
                            },
                            direction: AxisDirection.up,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _txtCountry,
                              style: FontUtils.NORMAL,
                              maxLines: null,
                              maxLength: null,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: setWidth(8),
                                      bottom: setHeight(12),
                                      top: setHeight(12),
                                      right: setWidth(8)),
                                  isDense: true,
                                  hintText: 'Quốc tịch',
                                  hintStyle: FontUtils.NORMAL,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color: ColorUtils.text_regis),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                                  )
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getRegionListBloc.getListCountry(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                dense: true,
                                title: Text(suggestion.name, style: FontUtils.NORMAL),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                countryModel = suggestion;
                                _txtCountry.text = suggestion.name;
                              });
                            },
                          ),
                        ),

                        RichText(text: TextSpan(text: 'Địa chỉ hiện tại ', style: FontUtils.NORMAL, children: [
                          TextSpan(text: '*', style: FontUtils.NORMAL.copyWith(color: ColorUtils.noted_text_regis))
                        ]),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: setHeight(10), bottom: setHeight(10)),
                          child: TypeAheadField(
                            noItemsFoundBuilder: (context) {
                              return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Không tìm thấy kết quả",
                                    style: FontUtils.NORMAL,
                                  ));
                            },
                            direction: AxisDirection.up,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _txtTimTinhThanh,
                              style: FontUtils.NORMAL,
                              maxLines: null,
                              maxLength: null,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: setWidth(8),
                                      bottom: setHeight(12),
                                      top: setHeight(12),
                                      right: setWidth(8)),
                                  isDense: true,
                                  hintText: 'Chọn tỉnh/thành phố',
                                  hintStyle: FontUtils.NORMAL,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color: ColorUtils.text_regis),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                                  )
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getRegionListBloc.getListProvince(pattern);
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                dense: true,
                                title: Text(suggestion.name, style: FontUtils.NORMAL),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                provinceModel = suggestion;
                                _txtTimTinhThanh.text = suggestion.name;
                                _txtTimQuanHuyen.clear();
                                _txtTimXaPhuong.clear();
                                districtModel = null;
                                communeModel = null;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: setHeight(10), bottom: setHeight(10)),
                          child: TypeAheadField(
                            noItemsFoundBuilder: (context) {
                              return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Không tìm thấy kết quả",
                                    style: FontUtils.NORMAL,
                                  ));
                            },
                            direction: AxisDirection.up,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _txtTimQuanHuyen,
                              style: FontUtils.NORMAL,
                              maxLines: null,
                              maxLength: null,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: setWidth(8),
                                      bottom: setHeight(12),
                                      top: setHeight(12),
                                      right: setWidth(8)),
                                  isDense: true,
                                  hintText: 'Chọn huyện/quận',
                                  hintStyle: FontUtils.NORMAL,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: ColorUtils.text_regis),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                                  )
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getRegionListBloc.getListDistrict(
                                  pattern, provinceModel?.idStr ?? "");
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                dense: true,
                                title: Text(suggestion.name, style: FontUtils.NORMAL),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                districtModel = suggestion;
                                _txtTimQuanHuyen.text = suggestion.name;
                                _txtTimXaPhuong.clear();
                                communeModel = null;
                              });
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            top: setHeight(10), ),
                          child: TypeAheadField(
                            noItemsFoundBuilder: (context) {
                              return Container(
                                  padding: EdgeInsets.all(5),
                                  child: Text(
                                    "Không tìm thấy kết quả",
                                    style: FontUtils.NORMAL,
                                  ));
                            },
                            direction: AxisDirection.up,
                            textFieldConfiguration: TextFieldConfiguration(
                              controller: _txtTimXaPhuong,
                              style: FontUtils.NORMAL,
                              maxLines: null,
                              maxLength: null,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(
                                      left: setWidth(8),
                                      bottom: setHeight(12),
                                      top: setHeight(12),
                                      right: setWidth(8)),
                                  isDense: true,
                                  hintText: 'Chọn xã/phường',
                                  hintStyle: FontUtils.NORMAL,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: ColorUtils.text_regis),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(8)),
                                    borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                                  )
                              ),
                            ),
                            suggestionsCallback: (pattern) async {
                              return await getRegionListBloc.getListCommune(
                                  pattern, districtModel?.idStr ?? "");
                            },
                            itemBuilder: (context, suggestion) {
                              return ListTile(
                                dense: true,
                                title: Text(suggestion.name, style: FontUtils.NORMAL),
                              );
                            },
                            onSuggestionSelected: (suggestion) {
                              setState(() {
                                communeModel = suggestion;
                                _txtTimXaPhuong.text = suggestion.name;

                              });
                            },
                          ),
                        ),
                        itemInfo(hintText: 'Số nhà, đường ....',controller: _txtAdressRoad),
                        SizedBox(height: setHeight(16),),
                        itemInfo(title: 'Số điện thoại ', subTitle: '*',hintText: 'Nhập số điện thoại',controller: _txtPhoneNumber, isWrite: false),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Email ', hintText: 'Nhập địa chỉ Email', controller: _txtEmailUser),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Mã nhân viên ', hintText: 'Nhập mã nhân viên',isWrite: false, controller: _txtCodeUser),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Chức vụ ', hintText: 'Chọn chức vụ',isWrite: false, controller: _txtPosition),
                        SizedBox(height: setHeight(15),),
                        itemInfo(title: 'Đơn vị/ Phòng ban ', hintText: 'Chọn đơn vị/ phòng ban',isWrite: false, controller: _txtStructDep),
                        SizedBox(height: setHeight(40),),
                        Center(
                          child: CustomButton(height: setHeight(42),width: setWidth(200),bgColor: ColorUtils.MAIN_GRADIENT_1,borderRadius: setWidth(12),
                            title: 'Cập nhật',margin: EdgeInsets.only(bottom: setHeight(90)),
                            onTap: (){
                              updateInfo();
                            },),
                        )

                      ],
                    ),
                  )
              );
            }
            else {
              return SizedBox();
            }

          },
        ),
      ),
    );
  }

  void radioButtonChanges(String value) {
    setState(() {
      _radioValue = value;
      print(_radioValue);
    });
  }

  Widget itemInfo({String title, String subTitle,String hintText, TextEditingController controller,bool isWrite = true,
    Widget icon,  Function onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(text: title, style: FontUtils.NORMAL, children: [
          TextSpan(text: subTitle, style: FontUtils.NORMAL.copyWith(color: ColorUtils.noted_text_regis))
        ]),
        ) ,
        SizedBox(height: setHeight(8),),
        Container(
          height: setHeight(40),color: ColorUtils.Noted_background_regis,alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              TextField(
                onChanged: onChanged,
                controller: controller,
                textAlign: TextAlign.start,
                style: FontUtils.NORMAL,
                textAlignVertical: TextAlignVertical.bottom,
                enabled: isWrite,
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: FontUtils.NORMAL.copyWith(color: ColorUtils.color_hintText),
                  // prefixIcon: Icon(Icons.event),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: setWidth(1),color: ColorUtils.text_regis),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                    )
                ),
              ),
             icon !=null ? Positioned(top: setHeight(0),bottom: 0,right: 0 ,child: icon) : SizedBox()
            ],
          ),
        )
      ],
    );
  }

  Widget itemInfoDate({String title, String subTitle,String hintText, TextEditingController controller,bool isWrite = true,
    Widget icon,  Function onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(text: title, style: FontUtils.NORMAL, children: [
          TextSpan(text: subTitle, style: FontUtils.NORMAL.copyWith(color: ColorUtils.noted_text_regis))
        ]),
        ) ,
        SizedBox(height: setHeight(8),),
        Container(
          height: setHeight(40),color: ColorUtils.Noted_background_regis,alignment: Alignment.centerLeft,
          child: Stack(
            children: [
              TextField(
                onChanged: onChanged,
                controller: controller,
                keyboardType: TextInputType.datetime,
                textAlign: TextAlign.start,
                style: FontUtils.NORMAL,
                textAlignVertical: TextAlignVertical.bottom,
                enabled: isWrite,
                decoration: InputDecoration(
                    hintText: hintText,
                    hintStyle: FontUtils.NORMAL.copyWith(color: ColorUtils.color_hintText),
                    // prefixIcon: Icon(Icons.event),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: setWidth(1),color: ColorUtils.text_regis),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(width: setWidth(1),color:ColorUtils.text_regis),
                    )
                ),
              ),
              icon !=null ? Positioned(top: setHeight(0),bottom: 0,right: 0 ,child: icon) : SizedBox()
            ],
          ),
        )
      ],
    );
  }
  Widget itemRadioBT({String title, String subTitle}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(text: TextSpan(text: title, style: FontUtils.NORMAL.copyWith(color: ColorUtils.text_regis), children: [
          TextSpan(text: subTitle, style: FontUtils.NORMAL.copyWith(color: ColorUtils.noted_text_regis))
        ]),),
        Row(
          children: [
            Radio(
                value: 'M',
                groupValue: _radioValue,
                activeColor: ColorUtils.MAIN_GRADIENT_1,
                onChanged: radioButtonChanges),
            Text('Nam'),
            Radio(
                value: 'F',
                activeColor: ColorUtils.MAIN_GRADIENT_1,
                groupValue: _radioValue,
                onChanged: radioButtonChanges),
            Text('Nữ')
          ],
        ),
      ],
    );
  }

  void updateInfo() async{
    if (_txtName.text == null || _txtName.text == '') {
      Utilites.showToast(context, 'Bạn cần nhập họ tên');
      return;
    }
    if (_txtIdCardName.text == null || _txtIdCardName.text == '') {
      Utilites.showToast(context, 'Bạn cần nhập số CMT/CCCD/Hộ chiếu');
      return;
    }
    if (_txtBirthDay.text == null || _txtBirthDay.text == '') {
      Utilites.showToast(context, 'Bạn cần nhập ngày tháng năm sinh');
      return;
    }
    if (_txtTimTinhThanh.text == null || _txtTimTinhThanh.text == ''||
        _txtTimQuanHuyen.text == null || _txtTimQuanHuyen.text == ''
        ||_txtTimXaPhuong.text == null || _txtTimXaPhuong.text == '') {
      Utilites.showToast(context, 'Bạn cần nhập đầy đủ thông tin địa chỉ hiện tại');
      return;
    }
    if(!Validator().IsPhoneNumber(_txtPhoneNumber.text)){
      Utilites.showToast(context, 'Định dạng email chưa chính xác');
      return;
    }
    if(_txtEmailUser.text !=null && _txtEmailUser.text.length >0) {
      if(!Validator().IsEmail(_txtEmailUser.text)){
        Utilites.showToast(context, 'Định dạng email chưa chính xác');
        return;
      }
    }

    infoUser.profile.fullName = _txtName.text.trim();
    infoUser.profile.identifyNo = _txtIdCardName.text.trim();
    infoUser.profile.insuranceNo = _txtInsuranceCode.text.trim();
    infoUser.profile.birthdayStr = _txtBirthDay.text.trim();
    infoUser.profile.gender = _radioValue;
    infoUser.profile.country = _txtCountry.text.trim();
    infoUser.profile.province = _txtTimTinhThanh.text.trim();

//tỉnh thành
    if(provinceModel?.name !=null && provinceModel?.name?.length > 0) {
      infoUser.profile.provinceId = provinceModel?.idStr??'';
      infoUser.profile.provinceIdStr = provinceModel?.idStr??'';
      infoUser.profile.provinceName = _txtTimTinhThanh.text??'';
    }


//tìm quận huyện
    if(districtModel?.idStr !=null && districtModel?.idStr?.length > 0) {
      infoUser.profile.districtId = districtModel?.idStr??'';
      infoUser.profile.districtIdStr = districtModel?.idStr??'';
      infoUser.profile.districtName = districtModel?.name??'';
    }
//tim xã phường
    if(communeModel?.idStr !=null && communeModel?.idStr?.length > 0) {
      infoUser.profile.communeId =  communeModel?.idStr??'';
      infoUser.profile.communeIdStr =  communeModel?.idStr??'';
      infoUser.profile.communeName =  communeModel?.name??'';
    }
    infoUser.profile.address = _txtAdressRoad.text;
    infoUser.mobile = _txtPhoneNumber.text.trim();
    infoUser.email = _txtEmailUser.text.trim();
    infoUser.employeeCode = _txtCodeUser.text.trim();
    infoUser.profile.provinceIdStr = provinceModel?.idStr??''.trim();
        updateProfileBloc.onUpdateProfile(infoUser);
  }

  upLoadImage(Asset asset) async {
    final filePath = await FlutterAbsolutePath.getAbsolutePath(asset.identifier);
    if (filePath != null) {
      File file;
      if (filePath.toLowerCase().endsWith("heic")) {
        file = File(await HeicToJpg.convert(filePath));
      } else {
        file = File(filePath);
      }

      var bufferFile = await Utilites.compress(
          file.path, await Utilites.getQuantity(file.path));

      if (bufferFile == null) {
        showMessage(context, "Có lỗi khi tải ảnh");
        return;
      }
      // ignore: unrelated_type_equality_checks

      UploadImageBloc().uploadFileMultiPart(bufferFile, file).then((response) async {
        if (response.data.ErrorCode == AppConstants.ERROR_CODE_SUCCESS) {
          if (response.data.Data.length > 0) {
            String imgPath = await AppUtils.shared
                .pushWidgetValueReturn(context, UpdateAvatar(response.data.Data[0]));
            if (imgPath != null && imgPath.isNotEmpty) {
              setState(() {
                GlobalCache().loginData.userInfo.profile.avatarUrl=imgPath;
                bloc.getProfile(context);
              });
            }
          }
        } else {
          showMessage(
              context,
              (response.data.ErrorMessage ?? "").isEmpty
                  ? response.data.ErrorCode
                  : response.data.ErrorMessage);
        }
      }
      );
    }
  }

  showConfirmDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
            child: Container(
              width: setWidth(310),
              padding: EdgeInsets.all(
                setHeight(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: setHeight(27),
                  ),
                  Text(
                    "Bạn vui lòng chụp theo ảnh mẫu",
                    style: FontUtils.NORMAL,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Image.asset(getAssetsImage('anh_chup_mau.png'), height: setWidth(151),width: setWidth(151),),
                  MaterialButton(
                    onPressed: () async {
                      List<Asset> resultList = await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
                      if (!mounted) return;
                      if (resultList.length > 0) {
                        var image =  resultList.first;
                        upLoadImage(image);
                      }
                      pop(context);
                    },
                  child: Container(height: setHeight(42),width: setWidth(270),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(setWidth(12)), color: ColorUtils.MAIN_GRADIENT_1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.camera_alt_outlined, size: 15,color: ColorUtils.WHITE,),
                        SizedBox(width: setWidth(8),),
                        Text('Chụp ảnh', style: FontUtils.NORMAL.copyWith(color: ColorUtils.WHITE),)
                      ],
                    ),
                  ),),

                  MaterialButton(
                    onPressed: (){
                      pop(context);
                    },
                    child: Container(height: setHeight(42),width: setWidth(270),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(setWidth(12)),
                          color: ColorUtils.WHITE,border: Border.all(color: ColorUtils.text_regis.withOpacity(0.3))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Đóng', style: FontUtils.NORMAL.copyWith(color: ColorUtils.text_regis),)
                        ],
                      ),
                    ),)

                  // CustomButton(
                  //   title: "Có",
                  //   width: setWidth(270),
                  //   height: setHeight(42),
                  //   onTap: () async {
                  //     List<Asset> resultList = await MultiImagePicker.pickImages(maxImages: 1, enableCamera: true);
                  //     if (!mounted) return;
                  //     if (resultList.length > 0) {
                  //       var image =  resultList.first;
                  //       upLoadImage(image);
                  //     }
                  //     pop(context);
                  //
                  //
                  //
                  //   },
                  // ),
                ],
              ),
            ),
          );
        });
  }
  InfoUser loadFromCache() {
    var userInfo = InfoUser();
    userInfo.fullName = GlobalCache().loginData.userInfo?.fullName??'';
    userInfo.mobile = GlobalCache().loginData.userInfo?.mobile??'';
    return userInfo;
  }
  Future<Null> _selectDate(BuildContext context, TextEditingController txtController) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1970, 8),
        lastDate: DateTime(2101));
    if (picked != null &&
        DateFormat('dd/MM/yyyy').format(picked) != txtController.text)
      setState(() {
        // selectedDate = picked;
        txtController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
  }
  @override
  void dispose() {
    super.dispose();
    bloc.dispose();
     _txtName.dispose();
     _txtIdCardName.dispose();
     _txtInsuranceCode.dispose();
     _txtBirthDay.dispose();
     _txtCountry.dispose();
     _txtAdressRoad.dispose();
     _txtPhoneNumber.dispose();
     _txtEmailUser.dispose();
     _txtCodeUser.dispose();
     _txtPosition.dispose();
     _txtStructDep.dispose();
     updateProfileBloc.dispose();
     _txtTimTinhThanh.dispose();
     _txtTimQuanHuyen.dispose();
     _txtTimXaPhuong.dispose();
  }


  @override
  void onError(String message) async {
    pop(context);
    Utilites.showToast(context, message);
  }

  @override
  void onRequesting() async {
showLoading(context);
    return;
  }

  @override
  void onSuccess(List<dynamic> response) async {
    Navigator.pop(context);
    GlobalCache().loginData.userInfo.fullName = infoUser.profile.fullName;
    GlobalCache().loginData.userInfo.profile.identifyNo = infoUser.profile.identifyNo;
    GlobalCache().loginData.userInfo.profile.insuranceNo = infoUser.profile.insuranceNo;
    GlobalCache().loginData.userInfo.profile.birthdayStr = infoUser.profile.birthdayStr;
    GlobalCache().loginData.userInfo.profile.gender = infoUser.profile.gender;
    GlobalCache().loginData.userInfo.profile.country = infoUser.profile.country;
    GlobalCache().loginData.userInfo.profile.province = infoUser.profile.province;
    GlobalCache().loginData.userInfo.profile.provinceName = infoUser.profile.provinceName;
    GlobalCache().loginData.userInfo.profile.provinceIdStr = infoUser.profile.provinceIdStr;
    GlobalCache().loginData.userInfo.profile.provinceId = infoUser.profile.provinceId;
    GlobalCache().loginData.userInfo.profile.districtName = infoUser.profile.districtName;
    GlobalCache().loginData.userInfo.profile.districtIdStr = infoUser.profile.districtIdStr;
    GlobalCache().loginData.userInfo.profile.districtId = infoUser.profile.districtId;
    GlobalCache().loginData.userInfo.profile.communeName = infoUser.profile.communeName;
    GlobalCache().loginData.userInfo.profile.communeId = infoUser.profile.communeId;
    GlobalCache().loginData.userInfo.profile.communeIdStr = infoUser.profile.communeIdStr;
    GlobalCache().loginData.userInfo.profile.address = infoUser.profile.address;
    GlobalCache().loginData.userInfo.profile.mobile = infoUser.profile.mobile;
    GlobalCache().loginData.userInfo.profile.email = infoUser.profile.email;
    GlobalCache().loginData.userInfo.profile.employeeCode = infoUser.profile.employeeCode;
    Utilites.showToast(context, 'Cập nhật thành công');
    Navigator.pop(context);

  }
}
