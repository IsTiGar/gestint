import 'package:gestint/models/course_model.dart';

abstract class CoursesViewContract{
  void onLoadCoursesComplete(List<Course> courseList);
  void onLoadCoursesError();
}