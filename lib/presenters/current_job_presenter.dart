
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class CurrentJobPresenter {
  CurrentJobViewContract _view;
  late DataRepository _repository;

  CurrentJobPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getCurrentJob(String owner){
    _repository.getCurrentJob(owner)
        .then((job) => _view.onLoadCurrentJobComplete(job))
        .catchError((onError) {
          print('El error es: ' + onError.toString());
          _view.onLoadCurrentJobError();
    });
  }

}