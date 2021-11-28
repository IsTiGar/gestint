import 'package:gestint/models/current_job_model.dart';

abstract class SingleProcedureViewContract{
  void onLoadSingleProcedureComplete(List<CurrentJob> jobList);
  void onLoadSingleProcedureError();
}