
import 'package:gestint/contracts/worker_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class WorkerPresenter {
  WorkerViewContract _view;
  late DataRepository _repository;

  WorkerPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getWorkerProfile(){
    _repository.getWorker("X46959966")
        .first
        .then((stream) => _view.onLoadWorkerComplete(stream.first))
        .catchError((onError) {
          _view.onLoadWorkerError();
      });
  }

}