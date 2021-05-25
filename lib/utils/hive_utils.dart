// import 'dart:convert';
// import 'package:blife/main.dart';
// import 'package:blife/model/beans/user/MemberData.dart';
// import 'package:blife/utils/app_constant.dart';
//
// class HiveUtils {
//   static HiveUtils shared = HiveUtils();
//
//   MemberData getMemberData() {
//     final data = userBox.get(AppConstants.HIVE_MEMBER_DATA);
//     if(data == null)
//       return MemberData();
//     final memberData = MemberData.fromJson(jsonDecode(data));
//     return memberData;
//   }
// }