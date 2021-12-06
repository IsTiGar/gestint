
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
          _view.onLoadSingleProcedureError();
    });
  }

  void registerProcedure(String procedureId, String userId, List<String> jobIdList){
    print(jobIdList);
    String jobIdListString = jobIdList.join(', ');
    print(jobIdListString);
    _repository.registerProcedure(procedureId, userId, jobIdListString)
        .then((result){
            _view.onRegisterProcedureComplete();
        })
        .catchError((onError) {
          _view.onRegisterProcedureError();
         });
    }
}