import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/blocs/get_not_declaration_list_bloc.dart';
import 'package:checkin/model/api_constants.dart';
import 'package:checkin/model/beans/employee_not_declare_model.dart';
import 'package:checkin/model/common/date_ranger_filter.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/widget/circle_avatar.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/custom_loading.dart';
import 'package:checkin/widget/fail_widget.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_widget.dart';
import 'package:checkin/widget/showMessage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'dart:async';

class EmployeeNotDeclaredView extends StatefulWidget {
  @override
  _EmployeeNotDeclaredViewState createState() =>
      _EmployeeNotDeclaredViewState();
}

class _EmployeeNotDeclaredViewState extends State<EmployeeNotDeclaredView> {
  NotDeclarationListBloc bloc = NotDeclarationListBloc();
  DateRangerModel _selectedDateRanger;
  List<DateRangerModel> _dropDownDateFilter = Utilites.getListFilteredDate();
  StreamController<int> _countEmployee = StreamController();

  @override
  void initState() {
    super.initState();
    _selectedDateRanger = _dropDownDateFilter[4];
    bloc.getNotDeclarationList(
        _selectedDateRanger.fromDateStr, _selectedDateRanger.toDateStr);
  }

  @override
  void dispose() {
    bloc.dispose();
    _countEmployee.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, "Danh sách chưa khai báo"),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                left: setWidth(16),
                // top: setHeight(8),
                // bottom: setHeight(8),
                right: setWidth(16)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  initialData: 0,
                  stream: _countEmployee.stream,
                  builder: (context, snapshot) {
                    return Text(
                      'Tổng: ${snapshot.data} nhân viên',
                      style: FontUtils.BOLD,
                    );
                  },
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
                          initialFirstDate: DateTime.now().subtract(
                              Duration(days: DateTime.now().day - 1)),
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
                              bloc.getNotDeclarationList(
                                  _selectedDateRanger.fromDateStr,
                                  _selectedDateRanger.toDateStr,
                                  isRefresh: true);
                            });
                          }
                        }
                      } else {
                        setState(() {
                          _dropDownDateFilter[6].label = "Tùy chọn";
                          _selectedDateRanger = newValue;
                          bloc.getNotDeclarationList(
                              _selectedDateRanger.fromDateStr,
                              _selectedDateRanger.toDateStr,
                              isRefresh: true);
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
          Container(
            height: setHeight(45),
            padding: EdgeInsets.only(left: setWidth(32), right: setWidth(32)),
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
                  'Nhân viên',
                  style: FontUtils.BOLD,
                ),
                Text(
                  'Chức danh',
                  style: FontUtils.BOLD,
                ),
              ],
            ),
          ),
          StreamBuilder(
            stream: bloc.getNotDeclarationListStream,
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
                      onTap: () => bloc.getNotDeclarationList(
                          _selectedDateRanger.fromDateStr,
                          _selectedDateRanger.toDateStr),
                    );
                    break;
                  case StreamEventType.Loaded:
                    List<NotDeclareModel> employeeList = bloc.listData;
                    _countEmployee.sink.add(employeeList.length);
                    if (employeeList.length == 0)
                      return Container(
                        padding: EdgeInsets.only(top: setHeight(50)),
                        child: Center(
                          child: Text('Danh sách chưa khai báo trống'),
                        ),
                      );
                    return Expanded(
                      child: ListView.builder(
                        // shrinkWrap: true,
                        itemCount: bloc.getListLength(),
                        itemBuilder: (context, index) {
                          if (bloc.canLoadMore(index, bloc.getListLength())) {
                            bloc.getNotDeclarationList(
                                _selectedDateRanger.fromDateStr,
                                _selectedDateRanger.toDateStr);
                            return customLoading;
                          }
                          return ListTile(
                            leading: circleAvatar(
                                ApiConstants().getFullImage(employeeList[index]
                                        .employeeInfo
                                        .imageAvatar ??
                                    ""),
                                employeeList[index].employeeInfo.name,
                                radius: setWidth(25)),
                            title: Text(
                              employeeList[index].employeeInfo.name ?? "",
                              style: FontUtils.SEMIBOLD,
                            ),
                            subtitle: Text(
                              employeeList[index].dateStr ?? "",
                              style: FontUtils.NORMAL,
                            ),
                            trailing: Text(
                              employeeList[index]
                                      .employeeInfo
                                      .positionInfo
                                      .name ??
                                  "",
                              style: FontUtils.NORMAL
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
}
