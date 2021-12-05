
import 'package:gestint/contracts/destinations_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class DestinationsPresenter {
  DestinationsViewContract _view;
  late DataRepository _repository;

  DestinationsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getDestinations(String id){
    _repository.getDestinations(id)
        .then((destinationList) => _view.onLoadDestinationsComplete(destinationList))
        .catchError((onError) {
          _view.onLoadDestinationsError();
        });
  }

}