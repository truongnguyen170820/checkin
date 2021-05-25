// import 'package:checkin/blocs/bloc_impl/event_type.dart';
// import 'package:checkin/blocs/bloc_impl/stream_event.dart';
// import 'package:checkin/blocs/user/bloc_get_declared_manager.dart';
// import 'package:checkin/model/common/date_ranger_filter.dart';
// import 'package:checkin/utils/TextStyles.dart';
// import 'package:checkin/utils/color_utils.dart';
// import 'package:checkin/utils/font_utils.dart';
// import 'package:checkin/utils/utilities.dart';
// import 'package:checkin/views/user/user_has_declared.dart';
// import 'package:checkin/widget/circle_avatar.dart';
// import 'package:checkin/widget/common_appbar.dart';
// import 'package:checkin/widget/custom_loading.dart';
// import 'package:checkin/widget/fail_widget.dart';
// import 'package:checkin/widget/global.dart';
// import 'package:checkin/widget/loading_widget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
//
// class DeclareManager extends StatefulWidget {
//
//   @override
//   _DeclareManagerState createState() => _DeclareManagerState();
// }
//
// class _DeclareManagerState extends State<DeclareManager> {
//   UserHasDeclaredBloc bloc = UserHasDeclaredBloc();
//   DateRangerModel _selectedDateRanger;
//   List<DateRangerModel> _dropDownDateFilter = Utilites.getListFilteredDate();
//   String selectTypeView = "Tùy chọn" ;
//   @override
//   void initState() {
//     super.initState();
//     _selectedDateRanger = _dropDownDateFilter[4];
//     selectTypeView = _dropDownDateFilter[4].label;
//     bloc.getUserHasDeclaredList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: backAppBar(context, 'Quản lý khai báo'),
//       body: SafeArea(
//         child: Padding(
//           padding:  EdgeInsets.symmetric(horizontal: setWidth(16)),
//           child: Column(
//             children: [
//               Container(height: setHeight(1),width: double.infinity,color: ColorUtils.text_regis.withOpacity(0.2),),
//               SizedBox(height: setHeight(8),),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   Text('Tổng ${20} bản', style: FontUtils.BOLD,),
//                   Spacer(),
//                   Container(
//                     height: setHeight(40),
//                     padding: EdgeInsets.symmetric(horizontal: setWidth(16)),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: ColorUtils.text_regis.withOpacity(0.3)),
//                       borderRadius: BorderRadius.circular(12),),
//                     child: DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                         value: _selectedDateRanger,
//                         icon: Icon(Icons.keyboard_arrow_down),
//                         onChanged: (DateRangerModel newValue) async {
//                           if (newValue == _dropDownDateFilter[6]) {
//                             final List<DateTime> picked =
//                             await DateRangePicker.showDatePicker(
//                               context: context,
//                               initialFirstDate: DateTime.now()
//                                   .subtract(Duration(days: DateTime.now().day - 1)),
//                               initialLastDate: DateTime.now(),
//                               firstDate: new DateTime(2015),
//                               lastDate: new DateTime(2022),
//                             );
//                             if (picked != null && picked.length == 2) {
//                               Duration diff = picked[1].difference(picked[0]);
//                               if (diff.inDays.toInt() > 60) {
//                                 Utilites.showToast(context,
//                                     "Vui lòng chọn thời gian trong khoảng 60 ngày!");
//                               } else {
//                                 setState(() {
//                                   _dropDownDateFilter[6].label =
//                                       Utilites.dateToString(picked[0])
//                                           .substring(0, 5) +
//                                           "-" +
//                                           Utilites.dateToString(picked[1])
//                                               .substring(0, 5);
//                                   _selectedDateRanger = DateRangerModel(
//                                       "Tùy chọn", picked[0], picked[1], 6);
//                                 });
//                               }
//                             }
//                           }
//                           else {
//                             setState(() {
//                               _dropDownDateFilter[6].label = "Tùy chọn";
//                               _selectedDateRanger = newValue;
//
//                             });
//                           }
//                         },
//                         items: _dropDownDateFilter
//                             .map<DropdownMenuItem<DateRangerModel>>(
//                                 (DateRangerModel value) {
//                               selectTypeView =value.label;
//                               return DropdownMenuItem<DateRangerModel>(
//                                 value: value,
//                                 child: Row(
//                                   children: [
//                                     Text(
//                                       value.label,
//                                       style: TextStyles.common_text, //3ouf
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             }).toList(),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: setHeight(12),),
//               Container(
//                 height: setHeight(45),width: double.infinity,
//                 padding: EdgeInsets.only(left: setWidth(28), right: setWidth(36)),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(8),
//                     color: ColorUtils.MAIN_GRADIENT_1.withOpacity(0.3),
//                     border: Border.all(color: ColorUtils.text_regis.withOpacity(0.3))),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('Nhân viên', style: FontUtils.NORMAL,),
//
//                     Text('Tình trạng', style: FontUtils.NORMAL,),
//
//                   ],
//                 ),
//               ),
//               SizedBox(height: setHeight(10),),
//               Expanded(
//                 child: StreamBuilder(
//                     stream: bloc.getHasDeclaredStream,
//                     builder: (context, snapshot) {
//                       if (snapshot.hasData) {
//                         StreamEvent event = snapshot.data;
//                         switch (event.eventType) {
//                           case StreamEventType.Loading:
//                             return LoadingWidget();
//                             break;
//                           case StreamEventType.Error:
//                             return InkWell(
//                               child: FailWidget(mess: event.message),
//                               onTap: () => bloc.getUserHasDeclaredList(),
//                             );
//                             break;
//                           case StreamEventType.Loaded:
//                             if (bloc.listData.length == 0)
//                               return Center(
//                                 child: Text('Không có thông tin dịch vụ'),
//                               );
//                             var listData = bloc.listData;
//                             return Container( width: double.infinity,height: double.infinity,
//                               child: ListView.builder(
//                                   itemCount: bloc.getListLength(),
//                                   itemBuilder: (context, index){
//                                     if(bloc.canLoadMore(index, bloc.getListLength())){
//                                       bloc.getUserHasDeclaredList();
//                                       return customLoading;
//                                     }
//                                     var listData = bloc.listData;
//                                     var user = listData[index];
//                                     return Container(
//                                       width: double.infinity,
//                                       padding: EdgeInsets.symmetric(vertical: setHeight(12)),
//                                       decoration: BoxDecoration(border: Border(bottom: BorderSide(color: ColorUtils.text_regis.withOpacity(0.3)))) ,
//                                       child:
//                                       Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: [
//                                           circleAvatar(user.faceUrl??'', user.fullName??user.mobile??'', radius: 24),
//                                           SizedBox(width: setWidth(8),),
//                                           Column(
//                                             mainAxisAlignment: MainAxisAlignment.center,
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Text(user.fullName??user.mobile??'', style: FontUtils.NORMAL,),
//                                               Text(user.depName??'Nhân Viên', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12)),),
//                                               Text(user.createdTimeStr.substring(10,14)??'', style: FontUtils.NORMAL.copyWith(fontSize: setSp(12), color: ColorUtils.text_regis ),),
//                                             ],
//                                           ),
//                                           Spacer(),
//                                           Text('Có biểu hiện', style: FontUtils.NORMAL.copyWith(color: ColorUtils.MAIN_GRADIENT_1),),
//                                           SizedBox(width: setWidth(13),),
//                                           Icon(Icons.arrow_forward_ios_rounded, size: 15,)
//                                         ],
//                                       ),
//                                     );
//                                   }),
//                             )
//
//                             ;
//                             break;
//                         }
//
//                         return Center(
//                             child: CupertinoActivityIndicator(
//                               radius: 15,
//                             ));
//                       }
//                       else {
//                         return Center(
//                             child: CupertinoActivityIndicator(
//                               radius: 15,
//                             ));
//                       }
//                     }
//                 ),
//               )
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//
//   Future<Null> _refreshPage()  async {
//     bloc.getUserHasDeclaredList(isRefresh: true);
//     return null;
//   }
// }
