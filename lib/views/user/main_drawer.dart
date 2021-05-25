// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:checkin/model/api_constants.dart';
// import 'package:checkin/model/repo/api_service.dart';
// import 'package:checkin/utils/TextStyles.dart';
// import 'package:checkin/utils/global_cache.dart';
// import 'package:checkin/views/user/login_account_view.dart';
// import 'package:checkin/views/user/user_profile_view.dart';
// import 'package:checkin/widget/global.dart';
//
// class MainDrawer extends StatefulWidget {
//   @override
//   _MainDrawerState createState() => _MainDrawerState();
// }
//
// class _MainDrawerState extends State<MainDrawer> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         children: <Widget>[
//           Container(
//             padding: EdgeInsets.only(
//                 left: setWidth(10), top: setHeight(10), bottom: setHeight(10)),
//             child: GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => UserProfileView())).then((value) {
//                   setState(() {});
//                 });
//               },
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 35,
//                     backgroundImage: CachedNetworkImageProvider(ApiConstants
//                         .shared
//                         .getFullImage(GlobalCache().loginData.userInfo.profile.avatarUrl)),
//                   ),
//                   Container(
//                     padding: EdgeInsets.only(left: 10),
//                     child: Text(
//                       GlobalCache().loginData.userInfo.fullName ??
//                           GlobalCache().loginData.userName,
//                       style: TextStyle(
//                           color: Colors.black54,
//                           fontSize: setSp(15),
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Divider(
//             thickness: 1,
//             color: Colors.black54,
//           ),
//
//           ListTile(
//             leading: Icon(Icons.info_outline),
//             title: Text(
//               'Thông tin tài khoản',
//               style: TextStyles.drawer_text,
//             ),
//             onTap: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => UserProfile())).then((value) {
//                 setState(() {});
//               });
//             },
//           ),
//           ListTile(
//             leading: Icon(Icons.logout),
//             title: Text(
//               'Đăng xuất',
//               style: TextStyles.drawer_text,
//             ),
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Row(
//                     children: [
//                       Icon(
//                         Icons.info_outline,
//                         size: 25,
//                       ),
//                       Text(' Đăng xuất', style: TextStyle(fontSize: setSp(15))),
//                     ],
//                   ),
//                   content: Text('Bạn có muốn đăng xuất?',
//                       style: TextStyle(fontSize: setSp(14))),
//                   actions: [
//                     FlatButton(
//                       child:
//                           Text('Không', style: TextStyle(fontSize: setSp(14))),
//                       onPressed: () {
//                         Navigator.of(context).pop();
//                       },
//                     ),
//                     FlatButton(
//                       child: Text('Có', style: TextStyle(fontSize: setSp(14))),
//                       onPressed: () async {
//                         // final storage = passwordStore.FlutterSecureStorage();
//                         // await storage.delete(key: AppConstants.KEY_USER_NAME);
//                         // await storage.delete(key: AppConstants.KEY_PASSWORD);
//                         ApiService(ApiConstants.SIGNOUT_ACCOUNT, {}, null)
//                             .getResponse();
//                         Navigator.pushAndRemoveUntil(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => LoginAccountView()),
//                             (route) => false);
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
// }
