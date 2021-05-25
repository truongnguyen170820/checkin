import 'package:checkin/blocs/add_declaration_bloc.dart';
import 'package:checkin/blocs/get_pathology_bloc.dart';
import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/remote/requests/declaration_request.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/views/main/home_page_view.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/custom_button.dart';
import 'package:checkin/widget/loading_request.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkin/blocs/bloc_impl/api_result_listener.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/widget/global.dart';
import 'package:intl/intl.dart';

class AddDeclarationView extends StatefulWidget {
  @override
  _AddDeclarationViewState createState() => _AddDeclarationViewState();
}

class _AddDeclarationViewState extends State<AddDeclarationView>
    implements ApiResultListener {
  TextEditingController _txtQuocGiaLanhTho = TextEditingController();
  GetPathologyListBloc getPathologyListBloc = GetPathologyListBloc();
  AddDeclarationBloc addDeclarationBloc = AddDeclarationBloc();

  DeclarationRequest declarationRequest = DeclarationRequest();
  bool tiepXucNguoiNghiNgoRadio = false;
  bool diTuVungDichRadio = false;
  bool tiepXucNguoiTuVungDichRadio = false;
  bool sotCheckbox = false;
  bool hoCheckbox = false;
  bool khoThoCheckbox = false;
  bool viemPhoiCheckbox = false;
  bool dauHongCheckbox = false;
  bool metMoiCheckbox = false;
  bool camKetCheckbox = true;
  List<PathologyModel> pathoList;
  List<String> benhLyListIdStr = [];

  @override
  void initState() {
    super.initState();
    addDeclarationBloc.initListener(this);
    if (GlobalCache().pathologyList == null) {
      getPathologyListBloc.initListener();
      getPathologyListBloc.getPathologyList();
    } else
      GlobalCache().pathologyList.forEach((element) {
        element.isChecked = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "Khai báo y tế", onBack: () {
        pop(context);
        resetPathologyList();
      }),
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
                Container(
                  padding: EdgeInsets.all(setWidth(12)),
                  decoration: BoxDecoration(
                      color: ColorUtils.RED_CARD,
                      borderRadius: BorderRadius.all(
                        Radius.circular(setWidth(5)),
                      )),
                  child: Text(
                    "Khuyến cáo: Khai báo thông tin sai là vi phạm pháp luật Việt Nam và có thể bị xử lý hình sự",
                    style: FontUtils.NORMAL.copyWith(
                        fontSize: setSp(13), color: ColorUtils.RED_TEXT),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Text(
                  "Trong vòng 14 ngày, Anh/Chị có:",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FlexColumnWidth(),
                    1: FixedColumnWidth(65),
                    2: FixedColumnWidth(65),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: <TableRow>[
                    TableRow(
                      decoration: BoxDecoration(
                          color: ColorUtils.MAIN_GRADIENT_2,
                          borderRadius: BorderRadius.all(
                            Radius.circular(setWidth(5)),
                          )),
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: setHeight(8), bottom: setHeight(8)),
                          child: Text(
                            "",
                            style:
                                FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Có",
                          style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Không",
                          style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(setWidth(8)),
                          child: Text(
                            "Có tiếp xúc với trường hợp bệnh hoặc nghi ngờ mắc bệnh COVID-19 không?",
                            style:
                                FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: tiepXucNguoiNghiNgoRadio,
                          onChanged: (value) {
                            setState(() {
                              tiepXucNguoiNghiNgoRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: tiepXucNguoiNghiNgoRadio,
                          onChanged: (value) {
                            setState(() {
                              tiepXucNguoiNghiNgoRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(setWidth(8)),
                          child: Text(
                            "Có đi từ vùng có dịch COVID-19 không?",
                            style:
                                FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: diTuVungDichRadio,
                          onChanged: (value) {
                            setState(() {
                              diTuVungDichRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: diTuVungDichRadio,
                          onChanged: (value) {
                            setState(() {
                              diTuVungDichRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                      ],
                    ),
                    TableRow(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(setWidth(8)),
                          child: Text(
                            "Có tiếp xúc với trường hợp đi về từ vùng dịch không?",
                            style:
                                FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          ),
                        ),
                        Radio(
                          value: true,
                          groupValue: tiepXucNguoiTuVungDichRadio,
                          onChanged: (value) {
                            setState(() {
                              tiepXucNguoiTuVungDichRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: tiepXucNguoiTuVungDichRadio,
                          onChanged: (value) {
                            setState(() {
                              tiepXucNguoiTuVungDichRadio = value;
                            });
                          },
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Text(
                  "Trong vòng 14 ngày, Anh/Chị có đến Quốc gia/Vùng lãnh thổ nào (có thể đi qua nhiều quốc gia):",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                TextField(
                  textAlignVertical: TextAlignVertical.center,
                  style: FontUtils.NORMAL,
                  controller: _txtQuocGiaLanhTho,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: setWidth(8),
                        bottom: setHeight(12),
                        top: setHeight(12),
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
                        color: Colors.black12,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Text(
                  "Trong vòng 14 ngày, Anh/Chị có thấy xuất hiện dấu hiệu nào sau đây không?",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Sốt",
                                style: FontUtils.NORMAL
                                    .copyWith(fontSize: setSp(13)),
                              ),
                            ),
                            Checkbox(
                              value: sotCheckbox,
                              activeColor: ColorUtils.TEXT_NORMAL,
                              checkColor: Colors.white,
                              onChanged: (bool newValue) {
                                setState(() {
                                  sotCheckbox = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: setWidth(16),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Viêm phổi",
                                style: FontUtils.NORMAL
                                    .copyWith(fontSize: setSp(13)),
                              ),
                            ),
                            Checkbox(
                              value: viemPhoiCheckbox,
                              activeColor: ColorUtils.TEXT_NORMAL,
                              checkColor: Colors.white,
                              onChanged: (bool newValue) {
                                setState(() {
                                  viemPhoiCheckbox = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Ho",
                                  style: FontUtils.NORMAL
                                      .copyWith(fontSize: setSp(13)),
                                ),
                              ),
                              Checkbox(
                                value: hoCheckbox,
                                activeColor: ColorUtils.TEXT_NORMAL,
                                checkColor: Colors.white,
                                onChanged: (bool newValue) {
                                  setState(() {
                                    hoCheckbox = newValue;
                                  });
                                },
                              ),
                            ],
                          )),
                      SizedBox(
                        width: setWidth(16),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Đau họng",
                                style: FontUtils.NORMAL
                                    .copyWith(fontSize: setSp(13)),
                              ),
                            ),
                            Checkbox(
                              value: dauHongCheckbox,
                              activeColor: ColorUtils.TEXT_NORMAL,
                              checkColor: Colors.white,
                              onChanged: (bool newValue) {
                                setState(() {
                                  dauHongCheckbox = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Khó thở",
                                style: FontUtils.NORMAL
                                    .copyWith(fontSize: setSp(13)),
                              ),
                            ),
                            Checkbox(
                              value: khoThoCheckbox,
                              activeColor: ColorUtils.TEXT_NORMAL,
                              checkColor: Colors.white,
                              onChanged: (bool newValue) {
                                setState(() {
                                  khoThoCheckbox = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: setWidth(16),
                      ),
                      Expanded(
                        flex: 1,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Mệt mỏi",
                                style: FontUtils.NORMAL
                                    .copyWith(fontSize: setSp(13)),
                              ),
                            ),
                            Checkbox(
                              value: metMoiCheckbox,
                              activeColor: ColorUtils.TEXT_NORMAL,
                              checkColor: Colors.white,
                              onChanged: (bool newValue) {
                                setState(() {
                                  metMoiCheckbox = newValue;
                                });
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                Text(
                  "Hiện tại Anh/Chị có các bệnh nào dưới đây?",
                  style: FontUtils.MEDIUM,
                ),
                SizedBox(
                  height: setHeight(10),
                ),
                StreamBuilder(
                  stream: getPathologyListBloc.getPathologyStream,
                  initialData: GlobalCache().pathologyList ?? [],
                  builder: (context, snapshot) {
                    pathoList = snapshot.data;
                    if (pathoList.length > 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pathoList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                              left: setWidth(16),
                              right: setWidth(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(
                                    pathoList[index].name ?? "",
                                    style: FontUtils.NORMAL
                                        .copyWith(fontSize: setSp(13)),
                                  ),
                                ),
                                Checkbox(
                                  value: pathoList[index].isChecked,
                                  activeColor: ColorUtils.TEXT_NORMAL,
                                  checkColor: Colors.white,
                                  onChanged: (bool newValue) {
                                    setState(() {
                                      pathoList[index].isChecked = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else {
                      return Container();
                    }
                  },
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
                        "Tôi cam kết các thông tin khai báo là đúng sự thật",
                        style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: setHeight(20),
                ),
                Center(
                    child: CustomButton(
                  title: "Gửi tờ khai",
                  onTap: sendDeclaration,
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

  void sendDeclaration() {
    FocusScope.of(context).unfocus();
    if (pathoList == null || pathoList.length == 0) {
      benhLyListIdStr = [];
    } else {
      pathoList.forEach((element) {
        if (element.isChecked) benhLyListIdStr.add(element.idStr);
      });
    }
    if (!camKetCheckbox) {
      showMessage(context, "Bạn phải cam kết khai báo đúng sự thật");
      return;
    }
    if (GlobalCache().loginData.userInfo.fullName == null ||
        GlobalCache().loginData.userInfo.fullName.isEmpty) {
      showMessage(context, "Bạn chưa nhập họ và tên trong Thông tin cá nhân");
      return;
    }

    if (GlobalCache().loginData.userInfo.profile.avatarUrl == null ||
        GlobalCache().loginData.userInfo.profile.avatarUrl.isEmpty) {
      showMessage(
          context, "Bạn chưa đăng ký ảnh đại diện trong Thông tin cá nhân");
      return;
    }
    if (GlobalCache().loginData.userInfo.profile.identifyNo == null ||
        GlobalCache().loginData.userInfo.profile.identifyNo.isEmpty) {
      showMessage(context, "Bạn chưa nhập CMND/CCCD trong Thông tin cá nhân");
      return;
    }
    // if ((GlobalCache().loginData.userInfo.profile.birthday == null ||
    //         GlobalCache().loginData.userInfo.profile.birthday.isEmpty) &&
    //     (GlobalCache().loginData.userInfo.profile.birthdayStr != null &&
    //         GlobalCache().loginData.userInfo.profile.birthdayStr.isNotEmpty)) {
    //   showMessage(context, "Bạn chưa nhập ngày sinh trong Thông tin cá nhân");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.provinceIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.provinceIdStr.isEmpty) {
    //   showMessage(
    //       context, "Bạn chưa chọn Tỉnh/Thành phố trong Thông tin cá nhân");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.districtIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.districtIdStr.isEmpty) {
    //   showMessage(context, "Bạn chưa chọn Huyện/Quận trong Thông tin cá nhân");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.communeIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.communeIdStr.isEmpty) {
    //   showMessage(context, "Bạn chưa chọn Xã/Phường trong Thông tin cá nhân");
    //   return;
    // }
    declarationRequest.domainIdStr = GlobalCache().loginData.domainIdStr;
    declarationRequest.fullName =
        GlobalCache().loginData.userInfo.profile.fullName ??
            GlobalCache().loginData.userInfo.fullName;
    declarationRequest.mobile = GlobalCache().loginData.userInfo.mobile ??
        GlobalCache().loginData.userName;
    declarationRequest.gender = GlobalCache().loginData.userInfo.profile.gender;
    declarationRequest.identityNo =
        GlobalCache().loginData.userInfo.profile.identifyNo;
    try {
      if (GlobalCache().loginData.userInfo.profile.birthdayStr != null &&
          GlobalCache().loginData.userInfo.profile.birthdayStr.isNotEmpty) {
        declarationRequest.yearOfBirth =
            DateTime.parse(GlobalCache().loginData.userInfo.profile.birthdayStr)
                .year;
      }
      if (GlobalCache().loginData.userInfo.profile.birthday != null &&
          GlobalCache().loginData.userInfo.profile.birthday.isNotEmpty) {
        declarationRequest.yearOfBirth =
            DateTime.parse(GlobalCache().loginData.userInfo.profile.birthday)
                .year;
      }
    } catch (e) {
      print("lỗi convert");
    }
    if (declarationRequest.yearOfBirth == null)
      declarationRequest.yearOfBirth = 1985;
    declarationRequest.provinceName =
        GlobalCache().loginData.userInfo.profile.province;
    declarationRequest.provinceIdStr =
        GlobalCache().loginData.userInfo.profile.provinceIdStr;
    declarationRequest.districtIdStr =
        GlobalCache().loginData.userInfo.profile.districtIdStr;
    declarationRequest.communeIdStr =
        GlobalCache().loginData.userInfo.profile.communeIdStr;
    declarationRequest.faceUrl =
        GlobalCache().loginData.userInfo.profile.avatarUrl;
    //ko bắt buộc
    declarationRequest.address =
        GlobalCache().loginData.userInfo.profile.address;
    declarationRequest.email = GlobalCache().loginData.userInfo.profile.email;
    // phần nhập vào

    declarationRequest.near30Status3 = tiepXucNguoiNghiNgoRadio;
    declarationRequest.near30Status4 = diTuVungDichRadio;
    declarationRequest.near30Status5 = tiepXucNguoiTuVungDichRadio;

    declarationRequest.checkHealthy5 = sotCheckbox;
    declarationRequest.checkHealthy6 = hoCheckbox;
    declarationRequest.checkHealthy7 = khoThoCheckbox;
    declarationRequest.checkHealthy8 = viemPhoiCheckbox;
    declarationRequest.checkHealthy9 = dauHongCheckbox;
    declarationRequest.checkHealthy10 = metMoiCheckbox;

    declarationRequest.countries = _txtQuocGiaLanhTho.text??"";
    //phần tạm thời fix
    declarationRequest.type = 0;
    declarationRequest.bodyTemperature = 0;
    declarationRequest.tempType = 0;
    declarationRequest.personType = 0;
    declarationRequest.jobType = 0;
    //
    if (benhLyListIdStr.length == 0) {
      declarationRequest.benhIdListStr = null;
    } else {
      declarationRequest.benhIdListStr = benhLyListIdStr;
    }
    declarationRequest.registerDateStr =
        DateFormat('dd/MM/yyyy').format(DateTime.now());
    addDeclarationBloc.addDeclaration(declarationRequest);
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
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 30,
                      ),
                      SizedBox(
                        width: setWidth(10),
                      ),
                      Text(
                        "Thoát phiếu",
                        style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Text(
                    "Bạn có muốn thoát khỏi phiếu khai báo y tế đang nhập?",
                    style: FontUtils.NORMAL,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        title: "Không",
                        width: setWidth(100),
                        height: setHeight(40),
                        bgColor: Colors.grey,
                        onTap: () {
                          pop(context);
                        },
                      ),
                      CustomButton(
                        title: "Có",
                        width: setWidth(100),
                        height: setHeight(40),
                        onTap: () {
                          resetPathologyList();
                          pop(context);
                          pop(context);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
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
    resetPathologyList();
    pop(context);
    Utilites.showToast(context, "Gửi khai báo y tế thành công");
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePageView()),
    );
  }

  void resetPathologyList() {
    GlobalCache().pathologyList.forEach((element) {
      element.isChecked = false;
    });
  }

  @override
  void dispose() {
    _txtQuocGiaLanhTho.dispose();
    getPathologyListBloc.dispose();
    addDeclarationBloc.dispose();
    super.dispose();
  }
}
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Bệnh gan mãn tính",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: ganManTinhCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             ganManTinhCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Bệnh máu mãn tính",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: mauManTinhCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             mauManTinhCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Bệnh phổi mãn tính",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: phoiManTinhCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             phoiManTinhCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Bệnh thận mãn tính",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: thanManTinhCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             thanManTinhCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Bệnh tim mạch",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: timMachCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             timMachCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Huyết áp cao",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: huyetApCaoCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             huyetApCaoCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "HIV hoặc suy giảm miễn dịch",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: hivSuyGiamMienDichCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             hivSuyGiamMienDichCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Người nhận ghép tạng, tủy xương",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: ghepTangTuyXuongCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             ghepTangTuyXuongCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Tiểu đường",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: tieuDuongCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             tieuDuongCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Ung thư",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: ungThuCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             ungThuCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
// Container(
//   padding:
//       EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
//   child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: <Widget>[
//       Expanded(
//         child: Text(
//           "Có thai",
//           style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
//         ),
//       ),
//       Checkbox(
//         value: coThaiCheckbox,
//         activeColor: ColorUtils.TEXT_NORMAL,
//         checkColor: Colors.white,
//         onChanged: (bool newValue) {
//           setState(() {
//             coThaiCheckbox = newValue;
//           });
//         },
//       ),
//     ],
//   ),
// ),
