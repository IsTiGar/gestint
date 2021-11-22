
import 'package:gestint/contracts/payroll_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class PayrollPresenter {
  PayrollViewContract _view;
  late DataRepository _repository;

  PayrollPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getPayroll(String id, int month, int year){
    _repository.getPayroll(id, month, year)
        .then((payroll) => _view.onLoadPayrollComplete(payroll))
        .catchError((onError) {
          print('El error es: ' + onError.toString());
          _view.onLoadPayrollError();
    });
  }

}