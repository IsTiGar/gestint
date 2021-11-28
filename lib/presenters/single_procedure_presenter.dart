
import 'package:gestint/contracts/single_procedure_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class SingleProcedurePresenter {
  SingleProcedureViewContract _view;
  late DataRepository _repository;

  SingleProcedurePresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getAvailableJobs(){
    _repository.getAvailableJobs()
        .then((jobList) => _view.onLoadSingleProcedureComplete(jobList))
        .catchError((onError) {
          print('El error es: ' + onError.toString());
          _view.onLoadSingleProcedureError();
    });
  }

}