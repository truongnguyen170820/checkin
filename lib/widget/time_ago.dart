import 'package:intl/intl.dart';

String timeAgo(String d) {
  if (d == null) {
    return '';
  }
  var stape = DateFormat("dd/MM/yyyy HH:mm:ss").parse(d, false);
  var timeNow = DateTime.now();
  Duration diff = timeNow.difference(stape);
  if (diff.inDays >= 365) return "${(diff.inDays / 365).floor()} năm trước";
  if (diff.inDays >= 30) return "${(diff.inDays / 30).floor()} tháng trước";
  if (diff.inDays >= 7) return "${(diff.inDays / 7).floor()} tuần trước";
  if (diff.inDays == 1) {
    return "Hôm qua";
  }
  if (diff.inDays > 1) return "${diff.inDays} ngày trước";
  if (diff.inHours > 0) return "${diff.inHours} giờ trước";
  if (diff.inMinutes > 0) return "${diff.inMinutes} phút trước";
  return "Vừa xong";
}
String formatTime(String time){
  var stape = DateFormat("dd/MM/yyyy HH:mm:ss").parse(time, false);
  DateFormat dateFormat = DateFormat("dd/MM/yyyy HH:mm");
  String timeFormat = dateFormat.format(stape);
  return timeFormat;

}


String formattedDate(DateTime dateTime) {
  print('dateTime ($dateTime)');
  return DateFormat("yyyy/M/d").format(dateTime);
}
String formatTimeBirthday(String time){
  var stape = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time, false);
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String timeFormat = dateFormat.format(stape);
  return timeFormat;

}String formatTimeSelect(String time){
  var stape = DateFormat("yyyy-MM-dd HH:mm:ss").parse(time, false);
  DateFormat dateFormat = DateFormat("dd/MM/yyyy");
  String timeFormat = dateFormat.format(stape);
  return timeFormat;

}
String formatTimeTraining(String time){
  var stape = DateFormat("yyyy-MM-ddTHH:mm:ss").parse(time, false);
  DateFormat dateFormat = DateFormat("HH:mm:ss");
  String timeFormat = dateFormat.format(stape);
  return timeFormat;

}