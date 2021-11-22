import 'package:gestint/models/school_model.dart';

abstract class SchoolsViewContract{
  void onLoadSchoolsComplete(List<School> schoolList);
  void onLoadSchoolsError();
}