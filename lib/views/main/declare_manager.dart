import 'dart:async';

import 'package:checkin/blocs/bloc_impl/event_type.dart';
import 'package:checkin/blocs/bloc_impl/stream_event.dart';
import 'package:checkin/blocs/user/bloc_get_declared_manager.dart';
import 'package:checkin/model/common/date_ranger_filter.dart';
import 'package:checkin/utils/TextStyles.dart';
import 'package:checkin/utils/color_utils.dart';
import 'package:checkin/utils/font_utils.dart';
import 'package:checkin/utils/utilities.dart';
import 'package:checkin/views/user/user_has_declared.dart';
import 'package:checkin/widget/circle_avatar.dart';
import 'package:checkin/widget/common_appbar.dart';
import 'package:checkin/widget/custom_loading.dart';
import 'package:checkin/widget/fail_widget.dart';
import 'package:checkin/widget/global.dart';
import 'package:checkin/widget/loading_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;

class DeclareManager extends StatefulWidget {

  @override
  _DeclareManagerState createState() => _DeclareManagerState();
}

class _DeclareManagerState extends State<DeclareManager> {

  UserHasDeclaredBloc bloc = UserHasDeclaredBloc();
  DateRangerModel _selectedDateRanger;
  List<DateRangerModel> _dropDownDateFilter = Utilites.getListFilteredDate();
  StreamController<int> _countEmployee = StreamController();

  @override
  void initState() {
    super.initState();
    _selectedDateRanger = _dropDownDateFilter[4];
    bloc.getUserHasDeclaredList(_selectedDateRanger.fromDateStr,
        _selectedDateRanger.toDateStr);


  }
@override
  void dispose() {
    super.dispose();
    bloc.dispose();
    _countEmployee.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: backAppBar(context, 'Quản lý khai báo'),
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: setWidth(16)),
          child: Column(
            children: [

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    initialData: 0,
                    stream:_countEmployee.stream ,
                    builder: (context, snapshot) {
                      return Text('Tổng: ${snapshot.data} bản',
                        style: FontUtils.BOLD,);
                    }
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
                              Utilites.showToast(context,
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
                                bloc.getUserHasDeclaredList(
                                    _selectedDateRanger.fromDateStr,
                                    _selectedDateRanger.toDateStr,
                                    isRefresh: true);
                              });
                            }
                          }
                        }
                        else {
                          setState(() {
                            _dropDownDateFilter[6].label = "Tùy chọn";
                            _selectedDateRanger = newValue;
                            bloc.getUserHasDeclaredList(
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
                              child: Row(
                                children: [
                                  Text(
                                    value.label,
                                    style: TextStyles.common_text, //3ouf
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: setHeight(12),),
              Container(
                height: setHeight(45),width: double.infinity,
                padding: EdgeInsets.only(left: setWidth(28), right: setWidth(36)),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorUtils.MAIN_GRADIENT_1.withOpacity(0.3),
                   ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Nhân viên', style: FontUtils.NORMAL,),

                    Text('Tình trạng', style: FontUtils.NORMAL,),

                  ],
                ),
              ),
              SizedBox(height: setHeight(10),),
              StreamBuilder(
                  stream: bloc.getHasDeclaredStream,
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
                            onTap: () => bloc.getUserHasDeclaredList(_selectedDateRanger.fromDateStr, _selectedDateRanger.toDateStr),
                          );
                          break;
                        case StreamEventType.Loaded:
                          _countEmployee.sink.add(bloc.getListLength());
                          if (bloc.listData.length == 0)
                            return Center(
                              child: Text('Danh sách nhân viên đang quản lý trống'),
                            );
                          return Expanded(
                            child: ListView.builder(
                              // shrinkWrap: true,
                                itemCount: bloc.getListLength(),
                                itemBuilder: (context, index){
                                  if(bloc.canLoadMore(index, bloc.getListLength())){
                                    bloc.getUserHasDeclaredList(_selectedDateRanger.fromDateStr,
                                        _selectedDateRanger.toDateStr);
                                    return customLoading;
                                  }
                                  var listData = bloc.listData;
                                  var user = listData[index];

                                  return Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(vertical: setHeight(12)),
                                    decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorUtils.text_regis.withOpacity(0.3)))) ,
                                    child:
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        circleAvatar(user.faceUrl??'', user.fullName??user.mobile??'', radius: 24),
                                        SizedBox(width: setWidth(8),),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(user.fullName??user.mobile??'', style: FontUtils.NORMAL,),
                                            Text(user.depName !=null && !user.depName.isEmpty ? user.depName : 'Nhân Viên', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12)),),
                                            Text(user.createdTimeStr??'', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.text_regis ),),
                                          ],
                                        ),
                                        Spacer(),
                                        Container(
                                          width: setWidth(70),
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: List.generate(checkStatus(user).length, (index) {
                                              return
                                                Padding(
                                                  padding:  EdgeInsets.symmetric(vertical: setHeight(1)),
                                                  child: checkStatus(user)[index],
                                                );
                                            }
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: setWidth(13),),
                                      ],
                                    ),
                                  );
                                }),
                          );
                          break;
                      }

                      return Center(
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ));
                    }
                    else {
                      return Center(
                          child: CupertinoActivityIndicator(
                            radius: 15,
                          ));
                    }
                  }
              )

            ],
          ),
        ),
      ),
    );
  }
  List<Text> checkStatus(UserHasDeclared user){
    List<Text> listStatus =[];
    if(user.near30Status3 || user.near30Status4 || user.near30Status5){
      listStatus.add(Text('Tiếp xúc', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12) ,color: Colors.black),));
    }
   if(user.checkHealthy5 || user.checkHealthy6 ||user.checkHealthy7 ||
       user.checkHealthy8 || user.checkHealthy9 ||user.checkHealthy10
   ) {
     listStatus.add(Text('Dấu hiệu', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12) ,color: Colors.redAccent),));
   }
   if(user.bodyTemperature >37) {
     listStatus.add(Text('Nhiệt độ', style: FontUtils.BOLD.copyWith(fontSize: setSp(12) ,color: Colors.orangeAccent),));
   }
   if(user.benhIdList !=null && !user.benhIdList.isEmpty){
     listStatus.add(Text('Bệnh nền', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12) ,color: Colors.deepPurple),));
   }
   if(listStatus.isEmpty){
     listStatus.add(Text('Bình Thường', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12) ,color: ColorUtils.MAIN_GRADIENT_1),));
   }
   return listStatus;
  }

}
