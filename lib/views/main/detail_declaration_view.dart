import 'package:checkin/blocs/get_pathology_bloc.dart';
import 'package:checkin/model/beans/declaration_history_model.dart';
import 'package:checkin/model/beans/pathology_model.dart';
import 'package:checkin/model/remote/requests/declaration_request.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/global_cache.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:checkin/widget/global.dart';

class DeclarationView extends StatefulWidget {
  final DeclarationHistoryModel declarationHistoryModel;
  DeclarationView(this.declarationHistoryModel);

  @override
  _DeclarationViewState createState() => _DeclarationViewState();
}

class _DeclarationViewState extends State<DeclarationView> {
  TextEditingController _txtQuocGiaLanhTho = TextEditingController();
  GetPathologyListBloc getPathologyListBloc = GetPathologyListBloc();

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
  List<String> benhLyListIdStr = [];

  @override
  void initState() {
    super.initState();
    tiepXucNguoiNghiNgoRadio = widget.declarationHistoryModel.near30Status3;
    diTuVungDichRadio = widget.declarationHistoryModel.near30Status4;
    tiepXucNguoiTuVungDichRadio = widget.declarationHistoryModel.near30Status5;
    sotCheckbox = widget.declarationHistoryModel.checkHealthy5;
    hoCheckbox = widget.declarationHistoryModel.checkHealthy6;
    khoThoCheckbox = widget.declarationHistoryModel.checkHealthy7;
    viemPhoiCheckbox = widget.declarationHistoryModel.checkHealthy8;
    dauHongCheckbox = widget.declarationHistoryModel.checkHealthy9;
    metMoiCheckbox = widget.declarationHistoryModel.checkHealthy10;
    _txtQuocGiaLanhTho.text = widget.declarationHistoryModel.countries;
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
      appBar: backAppBar(
        context,
        "Chi ti???t khai b??o",
      ),
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
                  width: double.infinity,
                  padding: EdgeInsets.all(setWidth(8)),
                  decoration: BoxDecoration(
                      color: ColorUtils.MAIN_GRADIENT_2,
                      borderRadius: BorderRadius.all(
                        Radius.circular(setWidth(5)),
                      )),
                  child: Text(
                    "Ng??y ${widget.declarationHistoryModel.registerDateStr??""}",
                    style: FontUtils.BOLD.copyWith(
                        fontSize: setSp(14)),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: setHeight(12),
                ),
                Text(
                  "B???n kh??ng th??? s???a b???n khai b??o n??y",
                  style: FontUtils.NORMAL.copyWith(color: Colors.redAccent),
                ),
                SizedBox(
                  height: setHeight(20),
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
                          onChanged: (value) {},
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: tiepXucNguoiNghiNgoRadio,
                          onChanged: (value) {},
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
                          onChanged: (value) {},
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: diTuVungDichRadio,
                          onChanged: (value) {},
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
                          onChanged: (value) {},
                          activeColor: ColorUtils.TEXT_NORMAL,
                        ),
                        Radio(
                          value: false,
                          groupValue: tiepXucNguoiTuVungDichRadio,
                          onChanged: (value) {},
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
                  enabled: false,
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
                              onChanged: (bool newValue) {},
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
                              onChanged: (bool newValue) {},
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
                                onChanged: (bool newValue) {},
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
                              onChanged: (bool newValue) {},
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
                              onChanged: (bool newValue) {},
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
                              onChanged: (bool newValue) {},
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
                    List<PathologyModel> pathoList = snapshot.data;
                    if (pathoList.length > 0) {
                      if (widget.declarationHistoryModel.benhIdListStr.length >
                          0) {
                        widget.declarationHistoryModel.benhIdListStr
                            .forEach((element) {
                          pathoList.forEach((e) {
                            if (e.idStr == element) e.isChecked = true;
                          });
                        });
                      }
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
                                  onChanged: (bool newValue) {},
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

  void resetPathologyList() {
    GlobalCache().pathologyList.forEach((element) {
      element.isChecked = false;
    });
  }

  @override
  void dispose() {
    _txtQuocGiaLanhTho.dispose();
    getPathologyListBloc.dispose();
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
