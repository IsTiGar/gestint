import 'package:gestint/models/certification_model.dart';

abstract class CertificationsContract {
  Future<List<Certification>> getCertifications(String id);
}