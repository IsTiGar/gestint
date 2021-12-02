
import 'package:gestint/contracts/user_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class UserPresenter {
  UserViewContract _view;
  late DataRepository _repository;

  UserPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void checkUserCredentials(String id, String password){
    _repository.checkUserCredentials(id, password)
        .then((result) => _view.onCheckUserCredentialsComplete(id, password, result))
        .catchError((onError) {
          _view.onCheckUserCredentialError();
    });
  }

}