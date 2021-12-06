
import 'package:gestint/contracts/charges_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class ChargesPresenter {
  ChargesViewContract _view;
  late DataRepository _repository;

  ChargesPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getCharges(String id){
    _repository.getCharges(id)
        .then((chargeList) => _view.onLoadChargesComplete(chargeList))
        .catchError((onError) {
          _view.onLoadChargesError();
        });
  }

}