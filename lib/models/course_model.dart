
class Course {

  final String title;
  final String description;
  final double hours;
  final String agency;
  final String startDate;
  final String endDate;
  final String strategicLine;
  final List<String> admittedList;
  final List<String> waitingList;
  final bool available;

  Course(
      this.title,
      this.description,
      this.hours,
      this.agency,
      this.startDate,
      this.endDate,
      this.strategicLine,
      this.admittedList,
      this.waitingList,
      this.available);

  Course.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        description = json['description'],
        hours = json['hours'] == null ? 0.0 : json['hours'].toDouble(), // forcefully convert to double
        agency = json['agency'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        strategicLine = json['strategicLine'],
        admittedList = List.from(json['admittedList']),
        waitingList = List.from(json['waitingList']),
        available = json['available'];

}
