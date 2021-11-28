
class CurrentJob {

  final String id;
  final String body;
  final String function;
  final String type;
  final bool partTime;
  final String school;
  final String city;
  final String startDate;
  final String endDate;

  CurrentJob(
      this.id,
      this.body,
      this.function,
      this.type,
      this.partTime,
      this.school,
      this.city,
      this.startDate,
      this.endDate);

  CurrentJob.fromSnapshot(Map<String, dynamic> json)
      : id = json['id'],
        body = json['body'],
        function = json['function'],
        type = json['type'],
        partTime = json['partTime'],
        school = json['school'],
        city = json['city'],
        startDate = json['startDate'],
        endDate = json['endDate'];

}
