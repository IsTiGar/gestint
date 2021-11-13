
import 'package:gestint/contracts/school_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class SchoolsPresenter {
  SchoolViewContract _view;
  late DataRepository _repository;

  SchoolsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getSchools(){
    _repository.getSchools()
        .then((schoolList) => _view.onSchoolsPetitionComplete(schoolList))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadSchoolsError();
        });
  }

}