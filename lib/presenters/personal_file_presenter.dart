
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class PersonalDataPresenter {
  PersonalDataViewContract _view;
  late DataRepository _repository;

  PersonalDataPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getPersonalData(String id){
    print('Buscando en presenter');
    _repository.getPersonalData(id)
        .then((pd) => _view.onLoadPersonalDataComplete(pd))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadPersonalDataError();
    });
  }

}