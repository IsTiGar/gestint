
import 'package:gestint/contracts/courses_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class CoursesPresenter {
  CoursesViewContract _view;
  late DataRepository _repository;

  CoursesPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getCourses(String cepCode){
    _repository.getCourses(cepCode)
        .then((courseList) => _view.onLoadCoursesComplete(courseList))
        .catchError((onError) {
          _view.onLoadCoursesError();
        });
  }

}