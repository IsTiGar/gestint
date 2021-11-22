import 'package:gestint/models/course_finished_model.dart';

abstract class CoursesFinishedViewContract{
  void onLoadCoursesFinishedComplete(List<CourseFinished> coursesFinishedList);
  void onLoadCoursesFinishedError();
}