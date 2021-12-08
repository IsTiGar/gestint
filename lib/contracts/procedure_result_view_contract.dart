import 'package:gestint/models/procedure_result_model.dart';

abstract class ProcedureResultViewContract{
  void onLoadProcedureResultComplete(List<ProcedureResult> procedureResultList);
  void onLoadProcedureResultError();
}