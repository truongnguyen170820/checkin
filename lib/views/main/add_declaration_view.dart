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
      appBar: backAppBar(context, "Khai b??o y t???", onBack: () {
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
                    "Khuy???n c??o: Khai b??o th??ng tin sai l?? vi ph???m ph??p lu???t Vi???t Nam v?? c?? th??? b??? x??? l?? h??nh s???",
                    style: FontUtils.NORMAL.copyWith(
                        fontSize: setSp(13), color: ColorUtils.RED_TEXT),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Text(
                  "Trong v??ng 14 ng??y, Anh/Ch??? c??:",
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
                          "C??",
                          style: FontUtils.NORMAL.copyWith(fontSize: setSp(13)),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Kh??ng",
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
                            "C?? ti???p x??c v???i tr?????ng h???p b???nh ho???c nghi ng??? m???c b???nh COVID-19 kh??ng?",
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
                            "C?? ??i t??? v??ng c?? d???ch COVID-19 kh??ng?",
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
                            "C?? ti???p x??c v???i tr?????ng h???p ??i v??? t??? v??ng d???ch kh??ng?",
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
                  "Trong v??ng 14 ng??y, Anh/Ch??? c?? ?????n Qu???c gia/V??ng l??nh th??? n??o (c?? th??? ??i qua nhi???u qu???c gia):",
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
                    hintText: "Nh???p th??ng tin",
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
                  "Trong v??ng 14 ng??y, Anh/Ch??? c?? th???y xu???t hi???n d???u hi???u n??o sau ????y kh??ng?",
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
                                "S???t",
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
                                "Vi??m ph???i",
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
                                "??au h???ng",
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
                                "Kh?? th???",
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
                                "M???t m???i",
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
                  "Hi???n t???i Anh/Ch??? c?? c??c b???nh n??o d?????i ????y?",
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
                        "T??i cam k???t c??c th??ng tin khai b??o l?? ????ng s??? th???t",
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
                  title: "G???i t??? khai",
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
      showMessage(context, "B???n ph???i cam k???t khai b??o ????ng s??? th???t");
      return;
    }
    if (GlobalCache().loginData.userInfo.fullName == null ||
        GlobalCache().loginData.userInfo.fullName.isEmpty) {
      showMessage(context, "B???n ch??a nh???p h??? v?? t??n trong Th??ng tin c?? nh??n");
      return;
    }

    if (GlobalCache().loginData.userInfo.profile.avatarUrl == null ||
        GlobalCache().loginData.userInfo.profile.avatarUrl.isEmpty) {
      showMessage(
          context, "B???n ch??a ????ng k?? ???nh ?????i di???n trong Th??ng tin c?? nh??n");
      return;
    }
    if (GlobalCache().loginData.userInfo.profile.identifyNo == null ||
        GlobalCache().loginData.userInfo.profile.identifyNo.isEmpty) {
      showMessage(context, "B???n ch??a nh???p CMND/CCCD trong Th??ng tin c?? nh??n");
      return;
    }
    // if ((GlobalCache().loginData.userInfo.profile.birthday == null ||
    //         GlobalCache().loginData.userInfo.profile.birthday.isEmpty) &&
    //     (GlobalCache().loginData.userInfo.profile.birthdayStr != null &&
    //         GlobalCache().loginData.userInfo.profile.birthdayStr.isNotEmpty)) {
    //   showMessage(context, "B???n ch??a nh???p ng??y sinh trong Th??ng tin c?? nh??n");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.provinceIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.provinceIdStr.isEmpty) {
    //   showMessage(
    //       context, "B???n ch??a ch???n T???nh/Th??nh ph??? trong Th??ng tin c?? nh??n");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.districtIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.districtIdStr.isEmpty) {
    //   showMessage(context, "B???n ch??a ch???n Huy???n/Qu???n trong Th??ng tin c?? nh??n");
    //   return;
    // }
    // if (GlobalCache().loginData.userInfo.profile.communeIdStr == null ||
    //     GlobalCache().loginData.userInfo.profile.communeIdStr.isEmpty) {
    //   showMessage(context, "B???n ch??a ch???n X??/Ph?????ng trong Th??ng tin c?? nh??n");
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
      print("l???i convert");
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
    //ko b???t bu???c
    declarationRequest.address =
        GlobalCache().loginData.userInfo.profile.address;
    declarationRequest.email = GlobalCache().loginData.userInfo.profile.email;
    // ph???n nh???p v??o

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
    //ph???n t???m th???i fix
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
                        "Tho??t phi???u",
                        style: FontUtils.MEDIUM.copyWith(fontSize: setSp(16)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: setHeight(20),
                  ),
                  Text(
                    "B???n c?? mu???n tho??t kh???i phi???u khai b??o y t??? ??ang nh???p?",
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
                        title: "Kh??ng",
                        width: setWidth(100),
                        height: setHeight(40),
                        bgColor: Colors.grey,
                        onTap: () {
                          pop(context);
                        },
                      ),
                      CustomButton(
                        title: "C??",
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
    Utilites.showToast(context, "G???i khai b??o y t??? th??nh c??ng");
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
//           "B???nh gan m??n t??nh",
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
//           "B???nh m??u m??n t??nh",
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
//           "B???nh ph???i m??n t??nh",
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
//           "B???nh th???n m??n t??nh",
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
//           "B???nh tim m???ch",
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
//           "Huy???t ??p cao",
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
//           "HIV ho???c suy gi???m mi???n d???ch",
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
//           "Ng?????i nh???n gh??p t???ng, t???y x????ng",
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
//           "Ti???u ???????ng",
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
//           "Ung th??",
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
//           "C?? thai",
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
