
import 'package:gestint/contracts/scale_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class ScalePresenter {
  ScaleViewContract _view;
  late DataRepository _repository;

  ScalePresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getScale(String id){
    _repository.getScale(id)
        .then((scale) => _view.onLoadScaleComplete(scale))
        .catchError((onError) {
          _view.onLoadScaleError();
    });
  }

}