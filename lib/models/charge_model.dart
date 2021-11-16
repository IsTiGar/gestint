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

}
