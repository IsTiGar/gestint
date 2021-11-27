
import 'package:gestint/models/current_job_model.dart';

abstract class CurrentJobContract {
  Future<CurrentJob> getCurrentJob(String id);
}