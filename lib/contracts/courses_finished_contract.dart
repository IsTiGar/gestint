
import 'package:gestint/models/course_finished_model.dart';

abstract class CoursesFinishedContract {
  Future<List<CourseFinished>> getCoursesFinished(String id);
}