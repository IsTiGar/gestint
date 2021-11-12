
import 'package:gestint/models/worker_model.dart';

abstract class WorkerContract {

  Stream<List<Worker>> getWorker(String id);
}