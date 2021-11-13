
import 'package:gestint/models/school_model.dart';

abstract class SchoolContract {
  Future<List<School>> getSchools();
}