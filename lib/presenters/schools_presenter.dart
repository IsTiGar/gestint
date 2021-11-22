
import 'package:gestint/contracts/schools_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class SchoolsPresenter {
  SchoolsViewContract _view;
  late DataRepository _repository;

  SchoolsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getSchools(){
    _repository.getSchools()
        .then((schoolList) => _view.onLoadSchoolsComplete(schoolList))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadSchoolsError();
        });
  }

}