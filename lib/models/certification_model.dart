
class Certification {

  final String title;
  final double qualification;
  final bool award;

  Certification(
      this.title,
      this.qualification,
      this.award);

  Certification.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        qualification = json['qualification'] == null ? 0.0 : json['qualification'].toDouble(), // forcefully convert int to double
        award = json['award'];

}
