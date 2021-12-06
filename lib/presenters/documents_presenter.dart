
import 'package:gestint/contracts/documents_view_contract.dart';
import 'package:gestint/helpers/injector.dart';
import 'package:gestint/repositories/data_repository.dart';

class DocumentsPresenter {
  DocumentsViewContract _view;
  late DataRepository _repository;

  DocumentsPresenter(this._view){
    _repository = new Injector().dataRepository;
  }

  void getDocuments(String id){
    _repository.getDocuments(id)
        .then((docList) => _view.onLoadDocumentsComplete(docList))
        .catchError((onError) {
          _view.onLoadDocumentsError();
        });
  }

}