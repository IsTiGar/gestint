
import 'package:gestint/contracts/certifications_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class CertificationsPresenter {
  CertificationsViewContract _view;
  late DataRepository _repository;

  CertificationsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getCertifications(String id){
    _repository.getCertifications(id)
        .then((certificationList) => _view.onLoadCertificationsComplete(certificationList))
        .catchError((onError) {
          _view.onLoadCertificationsError();
        });
  }

}