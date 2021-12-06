
import 'package:gestint/models/current_job_model.dart';

abstract class SingleProcedureContract {
  Future<List<CurrentJob>> getAvailableJobs();
  Future<void> registerProcedure(String procedureId, String userId, String jobIdList);
}