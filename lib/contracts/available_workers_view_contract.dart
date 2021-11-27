import 'package:gestint/models/worker_full_model.dart';

abstract class AvailableWorkersViewContract{
  void onLoadAvailableWorkersComplete(List<WorkerFull> availableWorkersList);
  void onLoadAvailableWorkersError();
}