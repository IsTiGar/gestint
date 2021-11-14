import 'package:gestint/models/personal_data_model.dart';

abstract class PersonalDataViewContract{
  void onLoadPersonalDataComplete(PersonalData personalData);
  void onLoadPersonalDataError();
}