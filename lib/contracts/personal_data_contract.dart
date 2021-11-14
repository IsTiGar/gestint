
import 'package:gestint/models/personal_data_model.dart';

abstract class PersonalDataContract {
  Future<PersonalData> getPersonalData(String id);
}