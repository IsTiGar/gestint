
import 'package:gestint/models/course_model.dart';

abstract class CoursesContract {
  Future<List<Course>> getCourses(String cep);
}