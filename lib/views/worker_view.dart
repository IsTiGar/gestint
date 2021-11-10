import 'package:gestint/models/worker_model.dart';

abstract class WorkerView{

  void onLoadWorkerComplete(Worker worker);
  void onLoadWorkerError();

}