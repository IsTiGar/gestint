
import 'package:gestint/models/procedure_result_model.dart';

abstract class ProcedureResultContract {
  Future<List<ProcedureResult>> getProcedureResult(String procedureId);
}