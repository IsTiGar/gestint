
import 'package:gestint/models/worker_full_model.dart';

abstract class AvailableWorkersContract {
  Future<List<WorkerFull>> getAvailableWorkers(String body, String function);
}