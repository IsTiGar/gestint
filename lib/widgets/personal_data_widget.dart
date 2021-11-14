import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/presenters/personal_file_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';

class PersonalDataWidget extends StatefulWidget{

  PersonalDataWidget({Key? key}) : super(key: key);

  @override
  State<PersonalDataWidget> createState() => _PersonalDataWidgetState();

}

class _PersonalDataWidgetState extends State<PersonalDataWidget> implements PersonalDataViewContract {

  bool _isLoading = true;
  late PersonalData _personalData;
  late PersonalDataPresenter _personalDataPresenter;

  @override
  void initState() {
    super.initState();
    _personalDataPresenter = PersonalDataPresenter(this);
    _personalDataPresenter.getPersonalData('X46959966');
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: _isLoading ? CustomProgressIndicatorWidget() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos de identificación',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
          Text('Nombre: ${_personalData.firstName} ${_personalData.lastName1} ${_personalData.lastName2}'),
          Text('NIF: ${_personalData.nif}'),
          Text('Nacionalidad: ${_personalData.nationality}'),
          SizedBox(height: 20,),
          Text(
            'Datos de nacimiento',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
          Text('Fecha de nacimiento: ${_personalData.dateOfBirth}'),
          Text('Sexo: ${_personalData.gender}'),
          Text('Província: ${_personalData.birthProvince}'),
          Text('Población: ${_personalData.birthCity}'),
          Text('Nación: ${_personalData.birthCountry}'),
          SizedBox(height: 20,),
          Text(
            'Datos de contacto',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
          Text('Dirección: ${_personalData.address}'),
          Text('Población: ${_personalData.city}'),
          Text('Província: ${_personalData.province}'),
          Text('Teléfono: ${_personalData.phoneNumber}'),
          Text('Correo electrónico: ${_personalData.emailAddress}'),
        ],
      ),
    );
  }

  @override
  void onLoadPersonalDataComplete(PersonalData personalData) {
    setState(() {
      _personalData = personalData;
      _isLoading = false;
    });
  }

  @override
  void onLoadPersonalDataError() {
    // TODO: implement onLoadPersonalDataError
  }
  

}