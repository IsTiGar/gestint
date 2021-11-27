import 'package:gestint/models/current_job_model.dart';

abstract class CurrentJobViewContract{
  void onLoadCurrentJobComplete(CurrentJob currentJob);
  void onLoadCurrentJobError();
}