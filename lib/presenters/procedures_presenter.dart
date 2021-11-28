
import 'package:gestint/contracts/procedures_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class ProceduresPresenter {
  ProceduresViewContract _view;
  late DataRepository _repository;

  ProceduresPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getProcedures(){
    _repository.getProcedures()
        .then((procedureList) => _view.onLoadProceduresComplete(procedureList))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadProceduresError();
        });
  }

}