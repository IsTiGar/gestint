
import 'package:gestint/models/worker_model.dart';

abstract class WorkerContract {
  Future<Worker> getWorker(String id);
}