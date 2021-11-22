import 'package:gestint/models/certification_model.dart';

abstract class CertificationsViewContract{
  void onLoadCertificationsComplete(List<Certification> certificationList);
  void onLoadCertificationsError();
}