import 'package:checkin/utils/utilities.dart';


class DateRangerModel {
  String label;
  DateTime fromDate;
  DateTime toDate;
  int id;
  get fromDateStr => Utilites.dateToString(fromDate);

  get toDateStr => Utilites.dateToString(toDate);

  DateRangerModel(this.label, this.fromDate, this.toDate, this.id);

  @override
  bool operator ==(Object other) {
    return other is DateRangerModel && this.id == other.id;
  }
}
