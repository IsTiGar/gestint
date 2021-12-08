
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/contracts/procedure_result_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class ProcedureResultsPresenter {
  ProcedureResultViewContract _view;
  late DataRepository _repository;

  ProcedureResultsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getProcedureResult(String procedureId){
    _repository.getProcedureResult(procedureId)
        .then((procedureResultList) => _view.onLoadProcedureResultComplete(procedureResultList))
        .catchError((onError) {
          print('Error es: ' + onError.toString());
          _view.onLoadProcedureResultError();
    });
  }

}