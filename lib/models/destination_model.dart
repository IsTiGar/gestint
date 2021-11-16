
class Destination {

  final String school;
  final String startDate;
  final String endDate;

  Destination(
      this.school,
      this.startDate,
      this.endDate);

  Destination.fromSnapshot(Map<String, dynamic> json)
      : school = json['school'],
        startDate = json['startDate'],
        endDate = json['endDate'];

}
