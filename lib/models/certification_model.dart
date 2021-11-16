import 'dart:ffi';

class Certification {

  final String title;
  final Float qualification;
  final bool award;

  Certification(
      this.title,
      this.qualification,
      this.award);

  Certification.fromSnapshot(Map<String, dynamic> json)
      : title = json['title'],
        qualification = json['qualification'],
        award = json['award'];

}
