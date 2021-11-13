import 'package:gestint/models/worker_model.dart';

abstract class WorkerViewContract{
  void onLoadWorkerComplete(Worker worker);
  void onLoadWorkerError();
}