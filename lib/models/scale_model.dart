import 'dart:ffi';

class Scale {

  final Float qualification;
  final Float publicExp;
  final Float privateExp;
  final Float universityExp;
  final Float academicQual;
  final Float phd;
  final Float other;
  final Float special;
  final Float catalan;
  final Float courses;
  final Float coursesHours;

  Scale(
      this.qualification,
      this.publicExp,
      this.privateExp,
      this.universityExp,
      this.academicQual,
      this.phd,
      this.other,
      this.special,
      this.catalan,
      this.courses,
      this.coursesHours);

  Scale.fromSnapshot(Map<String, dynamic> json)
      : qualification = json['qualification'],
        publicExp = json['publicExp'],
        privateExp = json['privateExp'],
        universityExp = json['universityExp'],
        academicQual = json['academicQual'],
        phd = json['phd'],
        other = json['other'],
        special = json['special'],
        catalan = json['catalan'],
        courses = json['courses'],
        coursesHours = json['coursesHours'];

}
