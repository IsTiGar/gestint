
import 'package:gestint/contracts/courses_finished_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class CoursesFinishedPresenter {
  CoursesFinishedViewContract _view;
  late DataRepository _repository;

  CoursesFinishedPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getCoursesFinished(String id){
    _repository.getCoursesFinished(id)
        .then((courseList) => _view.onLoadCoursesFinishedComplete(courseList))
        .catchError((onError) {
          print(onError.toString());
          _view.onLoadCoursesFinishedError();
        });
  }

}