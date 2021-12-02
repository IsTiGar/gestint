
import 'package:gestint/contracts/storage_view_contract.dart';
import 'package:gestint/models/storage_model.dart';

class StoragePresenter {
  StorageModel _storageModel;
  StorageViewContract _view;

  StoragePresenter(this._view, this._storageModel);


  void saveUserCredentials(String userId, String password){
    _storageModel.saveUserData(userId, password);
    print('Datos de usuario registrados');
  }

  void clearUserCredentials(){
    _storageModel.clearData();
    print('Datos de usuario borrados');
  }

  void getUserCredentials(){
    _storageModel.getUserId().then((userId){
      _storageModel.getPassword().then((password){
        _view.onGetCredentialsComplete(userId, password);
      });
    });
  }

}