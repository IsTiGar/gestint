
import 'package:gestint/contracts/available_workers_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class AvailableWorkersPresenter {
  AvailableWorkersViewContract _view;
  late DataRepository _repository;

  AvailableWorkersPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getAvailableWorkers(String body, String function){
    _repository.getAvailableWorkers(body, function)
        .then((workersList) => _view.onLoadAvailableWorkersComplete(workersList))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadAvailableWorkersError();
        });
  }

}