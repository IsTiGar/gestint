
import 'package:gestint/models/school_model.dart';

abstract class SchoolsContract {
  Future<List<School>> getSchools();
}