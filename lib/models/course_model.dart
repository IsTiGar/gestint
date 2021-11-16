import 'dart:ffi';

class Course {

  final String title;
  final Float hours;
  final String agency;
  final String startDate;
  final String endDate;
  final String infoUrl;
  final String strategicLine;
  final String admittedList;
  final String waitingList;
  final String inscribedList;

  Course(
      this.title,
      this.hours,
      this.agency,
      this.startDate,
      this.endDate,
      this.infoUrl,
      this.strategicLine,
      this.admittedList,
      this.waitingList,
      this.inscribedList);

  Course.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        hours = json['hours'],
        agency = json['agency'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        infoUrl = json['infoUrl'],
        strategicLine = json['strategicLine'],
        admittedList = json['admittedList'],
        waitingList = json['waitingList'],
        inscribedList = json['inscribedList'];

}
