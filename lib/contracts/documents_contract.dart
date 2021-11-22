
import 'package:gestint/models/document_model.dart';

abstract class DocumentsContract {
  Future<List<Document>> getDocuments(String id);
}