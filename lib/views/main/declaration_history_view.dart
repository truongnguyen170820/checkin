import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/blocs/declaration_history_bloc.dart';
import 'package:checkin/model/beans/declaration_history_model.dart';
import 'package:checkin/model/common/date_ranger_filter.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/views/main/detail_declaration_view.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/fail_widget.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_widget.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/intl.dart';

class DeclarationHistoryView extends StatefulWidget {
  @override
  _DeclarationHistoryViewState createState() => _DeclarationHistoryViewState();
}

class _DeclarationHistoryViewState extends State<DeclarationHistoryView> {
  DeclarationHistoryBloc bloc = DeclarationHistoryBloc();
  DateRangerModel _selectedDateRanger;
  List<DateRangerModel> _dropDownDateFilter = Utilites.getListFilteredDate();
  @override
  void initState() {
    super.initState();
    _selectedDateRanger = _dropDownDateFilter[4];
    bloc.getDeclarationList(
        _selectedDateRanger.fromDateStr,
        _selectedDateRanger.toDateStr,
        countDayBetween(
            _selectedDateRanger.fromDate, _selectedDateRanger.toDate));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "Lịch sử khai báo"),
      body: Column(
        children: [
          Container(
            height: setHeight(45),
            padding: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            margin: EdgeInsets.only(left: setWidth(16), right: setWidth(16)),
            decoration: BoxDecoration(
                color: ColorUtils.MAIN_GRADIENT_2,
                borderRadius: BorderRadius.all(
                  Radius.circular(setWidth(10)),
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Khoảng thời gian',
                  style: FontUtils.BOLD,
                ),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    value: _selectedDateRanger,
                    icon: Icon(Icons.keyboard_arrow_down),
                    onChanged: (DateRangerModel newValue) async {
                      if (newValue == _dropDownDateFilter[6]) {
                        final List<DateTime> picked =
                            await DateRangePicker.showDatePicker(
                          context: context,
                          initialFirstDate: DateTime.now()
                              .subtract(Duration(days: DateTime.now().day - 1)),
                          initialLastDate: DateTime.now(),
                          firstDate: new DateTime(2015),
                          lastDate: new DateTime(2022),
                        );
                        if (picked != null && picked.length == 2) {
                          Duration diff = picked[1].difference(picked[0]);
                          if (diff.inDays.toInt() > 60) {
                            showMessage(context,
                                "Vui lòng chọn thời gian trong khoảng 60 ngày!");
                          } else {
                            setState(() {
                              _dropDownDateFilter[6] = DateRangerModel(
                                  Utilites.dateToString(picked[0])
                                          .substring(0, 5) +
                                      "-" +
                                      Utilites.dateToString(picked[1])
                                          .substring(0, 5),
                                  picked[0],
                                  picked[1],
                                  6);
                              _selectedDateRanger = _dropDownDateFilter[6];
                              bloc.getDeclarationList(
                                  _selectedDateRanger.fromDateStr,
                                  _selectedDateRanger.toDateStr,
                                  countDayBetween(_selectedDateRanger.fromDate,
                                      _selectedDateRanger.toDate));
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _dropDownDateFilter[6].label = "Tùy chọn";
                          _selectedDateRanger = newValue;
                          bloc.getDeclarationList(
                              _selectedDateRanger.fromDateStr,
                              _selectedDateRanger.toDateStr,
                              countDayBetween(_selectedDateRanger.fromDate,
                                  _selectedDateRanger.toDate));
                          print("countday" +
                              countDayBetween(_selectedDateRanger.fromDate,
                                      _selectedDateRanger.toDate)
                                  .toString());
                        });
                      }
                    },
                    items: _dropDownDateFilter
                        .map<DropdownMenuItem<DateRangerModel>>(
                            (DateRangerModel value) {
                      return DropdownMenuItem<DateRangerModel>(
                        value: value,
                        child: Text(
                          value.label,
                          style: TextStyles.common_text,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: bloc.getDeclarationListStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                StreamEvent event = snapshot.data;
                switch (event.eventType) {
                  case StreamEventType.Loading:
                    return LoadingWidget();
                    break;
                  case StreamEventType.Error:
                    return InkWell(
                      child: FailWidget(mess: event.message),
                      onTap: () => bloc.getDeclarationList(
                          _selectedDateRanger.fromDateStr,
                          _selectedDateRanger.toDateStr,
                          countDayBetween(_selectedDateRanger.fromDate,
                              _selectedDateRanger.toDate)),
                    );
                    break;
                  case StreamEventType.Loaded:
                    List<DeclarationHistoryModel> declaredList = event.data;
                    List<DeclarationHistoryModel> declarationList =
                        List.generate(
                            countDayBetween(_selectedDateRanger.fromDate,
                                _selectedDateRanger.toDate),
                            (index) => DeclarationHistoryModel(
                                registerDateStr: DateFormat("dd/MM/yyyy")
                                    .format(_selectedDateRanger.toDate
                                        .subtract(Duration(days: index))),
                                declared: false));
                    checkDayExisted(declarationList, declaredList);
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: countDayBetween(_selectedDateRanger.fromDate,
                            _selectedDateRanger.toDate),
                        itemBuilder: (context, index) {
                          if (!declarationList[index].declared)
                            return ListTile(
                              dense: true,
                              title: Text(
                                declarationList[index].registerDateStr ?? "",
                                style: FontUtils.SEMIBOLD,
                              ),
                              trailing: Text(
                                "Chưa khai báo",
                                style: FontUtils.SEMIBOLD
                                    .copyWith(color: Colors.redAccent),
                              ),
                            );
                          return ListTile(
                            dense: true,
                            onTap: () {
                              pushTo(context,
                                  DeclarationView(declarationList[index]));
                            },
                            title: Text(
                              declarationList[index].registerDateStr ?? "",
                              style: FontUtils.SEMIBOLD,
                            ),
                            subtitle: Text(
                              declarationList[index].createdTime == null
                                  ? ""
                                  : declarationList[index]
                                      .createdTime
                                      .substring(11, 16),
                              style: FontUtils.NORMAL,
                            ),
                            trailing: Text(
                              "Đã khai báo",
                              style: FontUtils.SEMIBOLD
                                  .copyWith(color: ColorUtils.MAIN_GRADIENT_1),
                            ),
                          );
                        },
                      ),
                    );
                    break;
                  default:
                    return Container();
                }
              } else
                return Center(
                  child: CupertinoActivityIndicator(
                    radius: 15,
                  ),
                );
            },
          ),
        ],
      ),
    );
  }

  int countDayBetween(DateTime fromDate, DateTime toDate) {
    return toDate.difference(fromDate).inDays + 1;
  }

  void checkDayExisted(List<DeclarationHistoryModel> declarationList,
      List<DeclarationHistoryModel> declaredList) {
    for (int i = 0; i < declarationList.length; i++) {
      declaredList.forEach((e) {
        if (e.registerDateStr == declarationList[i].registerDateStr) {
          declarationList[i] = e;
        }
      });
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}

// import 'package:checkin/blocs/bloc_impl/event_type.dart';
// import 'package:checkin/blocs/bloc_impl/stream_event.dart';
// import 'package:checkin/blocs/declaration_history_bloc.dart';
// import 'package:checkin/model/beans/declaration_history_model.dart';
// import 'package:checkin/utils/font_utils.dart';
// import 'package:checkin/views/main/detail_declaration_view.dart';
// import 'package:checkin/widget/common_appbar.dart';
// import 'package:checkin/widget/custom_loading.dart';
// import 'package:checkin/widget/fail_widget.dart';
// import 'package:checkin/widget/global.dart';
// import 'package:checkin/widget/loading_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class DeclarationHistoryView extends StatefulWidget {
//   @override
//   _DeclarationHistoryViewState createState() => _DeclarationHistoryViewState();
// }
//
// class _DeclarationHistoryViewState extends State<DeclarationHistoryView> {
//   DeclarationHistoryBloc bloc = DeclarationHistoryBloc();
//   @override
//   void initState() {
//     super.initState();
//     bloc.getDeclarationList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: backAppBar(context, "Lịch sử khai báo"),
//       body: StreamBuilder(
//         stream: bloc.getDeclarationListStream,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             StreamEvent event = snapshot.data;
//             switch (event.eventType) {
//               case StreamEventType.Loading:
//                 return LoadingWidget();
//                 break;
//               case StreamEventType.Error:
//                 return InkWell(
//                   child: FailWidget(mess: event.message),
//                   onTap: () => bloc.getDeclarationList(),
//                 );
//                 break;
//               case StreamEventType.Loaded:
//                 List<DeclarationHistoryModel> declarationList = bloc.listData;
//                 if (declarationList.length == 0)
//                   return Center(
//                     child: Text('Không có khai báo y tế gần đây'),
//                   );
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: bloc.getListLength(),
//                   itemBuilder: (context, index) {
//                     if (bloc.canLoadMore(index, bloc.getListLength())) {
//                       bloc.getDeclarationList();
//                       return customLoading;
//                     }
//                     return GestureDetector(
//                       onTap: () {
//                         pushTo(
//                             context, DeclarationView(declarationList[index]));
//                       },
//                       child: ListTile(
//                         title: Text(
//                           declarationList[index].registerDateStr ?? "",
//                           style: FontUtils.SEMIBOLD,
//                         ),
//                         subtitle: Text(
//                           declarationList[index].createdTime == null
//                               ? ""
//                               : declarationList[index]
//                                   .createdTime
//                                   .substring(11, 16),
//                           style: FontUtils.NORMAL,
//                         ),
//                         trailing: Icon(
//                           Icons.arrow_forward_ios_rounded,
//                           size: 20,
//                         ),
//                       ),
//                     );
//                   },
//                 );
//                 break;
//               default:
//                 return Container();
//             }
//           } else
//             return Center(
//               child: CupertinoActivityIndicator(
//                 radius: 15,
//               ),
//             );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     bloc.dispose();
//     super.dispose();
//   }
// }
