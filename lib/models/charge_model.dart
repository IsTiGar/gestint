import 'package:age_calculator/age_calculator.dart';
import 'package:intl/intl.dart';

class Charge {

  final String body;
  final String type;
  final String school;
  final String startDate;
  final String endDate;

  Charge(
      this.body,
      this.type,
      this.school,
      this.startDate,
      this.endDate);

  Charge.fromSnapshot(Map<String, dynamic> json)
      : body = json['body'],
        type = json['type'],
        school = json['school'],
        startDate = json['startDate'],
        endDate = json['endDate'];

  List calculateTime() {
    final start = DateFormat('dd/MM/yyyy').parse(startDate);
    final end = DateFormat('dd/MM/yyyy').parse(endDate);
    // add 1 day for better calculations
    final adjustedEnd = new DateTime(end.year, end.month, end.day+1);

    final duration = AgeCalculator.dateDifference(
      fromDate: start,
      toDate: adjustedEnd,
    );

    return [duration.years, duration.months, duration.days];
  }

}
