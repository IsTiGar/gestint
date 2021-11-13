import 'package:gestint/models/school_model.dart';

abstract class SchoolViewContract{
  void onSchoolsPetitionComplete(List<School> schoolList);
  void onLoadSchoolsError();
}