import 'dart:ffi';

class Scale {

  final double publicExp;
  final double privateExp;
  final double universityExp;
  final double academicQual;
  final double phd;
  final double other;
  final double special;
  final double catalan;
  final double courses;
  final double coursesHours;

  Scale(
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
      : publicExp = json['publicExp'] == null ? 0.0 : json['publicExp'].toDouble(), // forcefully convert int to double
        privateExp = json['privateExp'] == null ? 0.0 : json['privateExp'].toDouble(),
        universityExp = json['universityExp'] == null ? 0.0 : json['universityExp'].toDouble(),
        academicQual = json['academicQual'] == null ? 0.0 : json['academicQual'].toDouble(),
        phd = json['phd'] == null ? 0.0 : json['phd'].toDouble(),
        other = json['other'] == null ? 0.0 : json['other'].toDouble(),
        special = json['special'] == null ? 0.0 : json['special'].toDouble(),
        catalan = json['catalan'] == null ? 0.0 : json['catalan'].toDouble(),
        courses = json['courses'] == null ? 0.0 : json['courses'].toDouble(),
        coursesHours = json['coursesHours'] == null ? 0.0 : json['coursesHours'].toDouble();

  String calculateTotalScale() {
    var _scaleDouble = publicExp + privateExp + universityExp + academicQual + phd + other + special + catalan + courses;
    return _scaleDouble.toStringAsFixed(3);
  }

}
