import 'package:gestint/models/procedure_model.dart';

abstract class ProceduresContract {
  Future<List<Procedure>> getProcedures();
}