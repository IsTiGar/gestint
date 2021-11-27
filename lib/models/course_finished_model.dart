
class CourseFinished {

  final String title;
  final String startDate;
  final String endDate;
  final String agency;
  final String strategicLine;
  final double hours;
  final String type;

  CourseFinished(
      this.title,
      this.startDate,
      this.endDate,
      this.agency,
      this.strategicLine,
      this.hours,
      this.type);

  CourseFinished.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        startDate = json['startDate'],
        endDate = json['endDate'],
        agency = json['agency'],
        strategicLine = json['strategicLine'],
        hours = json['hours'] == null ? 0.0 : json['hours'].toDouble(),
        type = json['type'];

}
