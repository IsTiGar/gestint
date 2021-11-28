import 'package:gestint/models/procedure_model.dart';

abstract class ProceduresViewContract{
  void onLoadProceduresComplete(List<Procedure> procedureList);
  void onLoadProceduresError();
}