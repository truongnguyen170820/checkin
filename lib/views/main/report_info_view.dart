import 'package:checkin/blocs/get_region_list_bloc.dart';
import 'package:checkin/blocs/report_infor_bloc.dart';
import 'package:checkin/model/beans/commune_model.dart';
import 'package:checkin/model/beans/district_model.dart';
import 'package:checkin/model/beans/province_model.dart';
import 'package:checkin/model/remote/requests/report_info_request.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/views/main/home_page_view.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/widget/global.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportInfomationView extends StatefulWidget {
  @override
  _ReportInfomationViewState createState() => _ReportInfomationViewState();
}

class _ReportInfomationViewState extends State<ReportInfomationView>
    implements ApiResultListener {
  TextEditingController _txtNoiDungPhanAnh = TextEditingController();
  TextEditingController _txtThoiGianPhatHien = TextEditingController();
  TextEditingController _txtTimTinhThanh = TextEditingController();
  TextEditingController _txtTimQuanHuyen = TextEditingController();
  TextEditingController _txtTimXaPhuong = TextEditingController();
  TextEditingController _txtSoNhaDuong = TextEditingController();

  GetRegionListBloc getRegionListBloc = GetRegionListBloc();
  ReportInfoBloc reportInfoBloc = ReportInfoBloc();
  ReportInfoRequest reportInfoRequest = ReportInfoRequest();
  ProvinceModel provinceModel;
  DistrictModel districtModel;
  CommuneModel communeModel;

  bool tiepXucNguoiNghiNgoCheckbox = false;
  bool diTuVungDichCheckbox = false;
  bool tiepXucNguoiTuVungDichCheckbox = false;
  bool camKetCheckbox = true;

  @override
  void initState() {
    super.initState();
    reportInfoBloc.initListener(this);
    _txtThoiGianPhatHien.text = DateFormat('dd/MM/yyyy').format(DateTime.now()) +
        ' ' +
        formatTime(TimeOfDay.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "Phản ánh thông tin"),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(setWidth(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Vui lòng nhập thông tin hoặc gọi đường dây nóng",
                    style: FontUtils.MEDIUM),
                SizedBox(
                  height: setHeight(12),
                ),
                Container(
                  height: setHeight(40),
                  decoration: BoxDecoration(
                      color: ColorUtils.RED_CARD,
                      borderRadius: BorderRadius.all(
                        Radius.circular(setWidth(5)),
                      )),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          makePhoneCall("19009065");
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorUtils.RED_LIGHT,
                              borderRadius: BorderRadius.all(
                                Radius.circular(setWidth(5)),
                              )),
                          width: setWidth(40),
                          height: setHeight(40),
                          child: Center(
                              child: Image.asset(
                            getAssetsIcon("telephone.png"),
                            width: setWidth(20),
                            height: setHeight(20),
                          )),
                        ),
                      ),
                      SizedBox(
                        width: setWidth(8),
                      ),
                      Text(
                        "19009065",
                        style: FontUtils.SEMIBOLD.copyWith(
                            fontSize: setSp(20), color: ColorUtils.RED_TEXT),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Text(
                  "Chọn các trường hợp phản ánh",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Checkbox(
                      value: tiepXucNguoiNghiNgoCheckbox,
                      activeColor: ColorUtils.TEXT_NORMAL,
                      checkColor: Colors.white,
                      onChanged: (bool newValue) {
                        setState(() {
                          tiepXucNguoiNghiNgoCheckbox = newValue;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Có người tiếp xúc với trường hợp bệnh hoặc nghi ngờ mắc bệnh COVID-19",
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Checkbox(
                      value: diTuVungDichCheckbox,
                      activeColor: ColorUtils.TEXT_NORMAL,
                      checkColor: Colors.white,
                      onChanged: (bool newValue) {
                        setState(() {
                          diTuVungDichCheckbox = newValue;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Có trường hợp đi về từ vùng dịch COVID-19",
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Checkbox(
                      value: tiepXucNguoiTuVungDichCheckbox,
                      activeColor: ColorUtils.TEXT_NORMAL,
                      checkColor: Colors.white,
                      onChanged: (bool newValue) {
                        setState(() {
                          tiepXucNguoiTuVungDichCheckbox = newValue;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Có người tiếp xúc với trường hợp đi về từ vùng dịch COVID-19",
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Text(
                  "Nội dung phản ánh khác",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: FontUtils.NORMAL,
                  controller: _txtNoiDungPhanAnh,
                  keyboardType: TextInputType.text,
                  maxLines: 4,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: setWidth(8),
                        bottom: setHeight(8),
                        top: setHeight(8),
                        right: setWidth(8)),
                    isDense: true,
                    hintText: "Nhập thông tin",
                    hintStyle: FontUtils.NORMAL.copyWith(
                        fontSize: setSp(13), color: ColorUtils.HINT_COLOR),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: ColorUtils.text_regis,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Row(
                  children: [
                    Text(
                      "Thời gian phát hiện",
                      style: FontUtils.MEDIUM,
                    ),
                    Text(" *", style: FontUtils.MEDIUM.copyWith(color: Colors.redAccent),)
                  ],
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Container(
                  height: setHeight(40),
                  color: ColorUtils.Noted_background_regis,
                  alignment: Alignment.centerLeft,
                  child: Stack(
                      alignment: AlignmentDirectional.centerEnd,
                      children: [
                        TextField(
                          controller: _txtThoiGianPhatHien,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.datetime,
                          style: FontUtils.NORMAL
                              .copyWith(color: ColorUtils.text_info),
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                            hintText: "dd/MM/yyyy hh:mm",
                            hintStyle: FontUtils.NORMAL
                                .copyWith(color: ColorUtils.color_hintText),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                              borderSide: BorderSide(
                                  width: setWidth(0.5),
                                  color: ColorUtils.text_regis),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.date_range,
                            color: ColorUtils.gray8,
                          ),
                          onPressed: () {
                            selectDate(context, _txtThoiGianPhatHien);
                          },
                        )
                      ]),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Row(
                  children: [
                    Text(
                      "Địa điểm xảy ra",
                      style: FontUtils.MEDIUM,
                    ),
                    Text(" *", style: FontUtils.MEDIUM.copyWith(color: Colors.redAccent),)
                  ],
                ),
                SizedBox(
                  height: setHeight(10),
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
                        hintStyle: FontUtils.NORMAL
                            .copyWith(color: ColorUtils.color_hintText),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: ColorUtils.text_regis),
                        ),
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
                        hintStyle: FontUtils.NORMAL
                            .copyWith(color: ColorUtils.color_hintText),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: ColorUtils.text_regis),
                        ),
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
                        hintStyle: FontUtils.NORMAL
                            .copyWith(color: ColorUtils.color_hintText),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          borderSide: BorderSide(color: ColorUtils.text_regis),
                        ),
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
                SizedBox(
                  height: setHeight(10),
                ),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: FontUtils.NORMAL,
                  controller: _txtSoNhaDuong,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: setWidth(8),
                        bottom: setHeight(12),
                        top: setHeight(12),
                        right: setWidth(8)),
                    isDense: true,
                    hintText: "Số nhà, đường...",
                    hintStyle: FontUtils.NORMAL.copyWith(
                        fontSize: setSp(13), color: ColorUtils.HINT_COLOR),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      borderSide: BorderSide(
                        color: ColorUtils.text_regis,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Checkbox(
                      value: camKetCheckbox,
                      activeColor: ColorUtils.TEXT_NORMAL,
                      checkColor: Colors.white,
                      onChanged: (bool newValue) {
                        setState(() {
                          camKetCheckbox = newValue;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "Tôi cam kết các thông tin khai báo là đúng sự thật và đồng ý chia sẻ vị trí để cơ quan chức năng có thể hỗ trợ tốt nhất.",
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(25),
                ),
                Center(
                    child: CustomButton(
                  title: "Gửi thông tin",
                  onTap: sendInformation,
                  width: setWidth(200),
                  height: setHeight(42),
                )),
                SizedBox(
                  height: setHeight(20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendInformation() {
    if (!tiepXucNguoiTuVungDichCheckbox &&
        !tiepXucNguoiNghiNgoCheckbox &&
        !diTuVungDichCheckbox &&
        (_txtNoiDungPhanAnh.text == null ||
            _txtNoiDungPhanAnh.text.trim().isEmpty)) {
      showMessage(context, "Bạn chưa cung cấp thông tin phản ánh");
      return;
    }
    if (_txtThoiGianPhatHien.text == null ||
        _txtThoiGianPhatHien.text.isEmpty) {
      showMessage(context, "Bạn chưa chọn thời điểm");
      return;
    }
    if (provinceModel == null) {
      showMessage(context, "Bạn chưa chọn Tỉnh/Thành phố");
      return;
    }
    if (districtModel == null) {
      showMessage(context, "Bạn chưa chọn Huyện/Quận");
      return;
    }
    if (communeModel == null) {
      showMessage(context, "Bạn chưa chọn Xã/Phường");
      return;
    }
    if (_txtSoNhaDuong.text == null || _txtSoNhaDuong.text.trim().isEmpty) {
      showMessage(context, "Bạn chưa nhập địa chỉ");
      return;
    }

    reportInfoRequest.type = [];
    if (tiepXucNguoiNghiNgoCheckbox) reportInfoRequest.type.add(0);
    if (diTuVungDichCheckbox) reportInfoRequest.type.add(1);
    if (tiepXucNguoiTuVungDichCheckbox) reportInfoRequest.type.add(2);
    reportInfoRequest.provinceIdStr = provinceModel.idStr;
    reportInfoRequest.districtIdStr = districtModel.idStr;
    reportInfoRequest.communeIdStr = communeModel.idStr;
    reportInfoRequest.address = _txtSoNhaDuong.text;
    reportInfoRequest.timeStr = _txtThoiGianPhatHien.text;
    reportInfoRequest.content = _txtNoiDungPhanAnh.text ?? "";
    reportInfoBloc.reportInfo(reportInfoRequest);
  }

  Future<Null> selectDate(
      BuildContext context, TextEditingController txtController) async {
    TimeOfDay pickedTime;
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970, 8),
      lastDate: DateTime(2101),
      helpText: 'Chọn ngày',
      cancelText: 'Hủy',
    );
    if (pickedDate != null) {
      pickedTime = await showTimePicker(
          context: context,
          builder: (BuildContext context, Widget child) {
            return MediaQuery(
              data:
                  MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child,
            );
          },
          helpText: 'Chọn thời gian',
          initialTime: TimeOfDay.now(),
          initialEntryMode: TimePickerEntryMode.dial,
          cancelText: 'Hủy');
      if (pickedTime != null) {
        setState(() {
          txtController.text = DateFormat('dd/MM/yyyy').format(pickedDate) +
              ' ' +
              formatTime(pickedTime);
        });
      }
    }
  }

  String formatTime(TimeOfDay pickedTime) {
    String hour;
    String minute;
    if (pickedTime.hour < 10) {
      hour = '0${pickedTime.hour}';
    } else
      hour = '${pickedTime.hour}';
    if (pickedTime.minute < 10) {
      minute = '0${pickedTime.minute}';
    } else
      minute = '${pickedTime.minute}';
    return hour + ':' + minute;
  }

  Future<void> makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onError(String message) async {
    pop(context);
    showMessage(context, message);
  }

  @override
  void onRequesting() {
    showLoading(context);
  }

  @override
  void onSuccess(List response) async {
    pop(context);
    showMessage(context, "Gửi thông tin thành công");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageView()),
    );
  }

  @override
  void dispose() {
    _txtNoiDungPhanAnh.dispose();
    _txtSoNhaDuong.dispose();
    _txtTimXaPhuong.dispose();
    _txtTimQuanHuyen.dispose();
    _txtTimTinhThanh.dispose();
    _txtThoiGianPhatHien.dispose();
    reportInfoBloc.dispose();
    super.dispose();
  }
}
