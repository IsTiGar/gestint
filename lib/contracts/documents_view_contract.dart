import 'package:gestint/models/document_model.dart';

abstract class DocumentsViewContract{
  void onLoadDocumentsComplete(List<Document> documentList);
  void onLoadDocumentsError();
}