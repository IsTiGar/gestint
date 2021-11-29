
import 'package:gestint/contracts/worker_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class WorkerPresenter {
  WorkerViewContract _view;
  late DataRepository _repository;

  WorkerPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getWorkerProfile(String id){
    _repository.getWorker(id)
        .then((worker) => _view.onLoadWorkerComplete(worker))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadWorkerError();
    });
  }

}