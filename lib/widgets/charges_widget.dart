import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/charges_view_contract.dart';
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/models/charge_model.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/presenters/charges_presenter.dart';
import 'package:gestint/presenters/current_job_presenter.dart';
import 'package:gestint/presenters/personal_file_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';

class ChargesWidget extends StatefulWidget{

  ChargesWidget({Key? key}) : super(key: key);

  @override
  State<ChargesWidget> createState() => _ChargesWidgetState();

}

class _ChargesWidgetState extends State<ChargesWidget> implements ChargesViewContract {

  bool _isLoading = true;
  late List<Charge> _chargesList;
  late ChargesPresenter _chargesPresenter;
  bool _chargesNotFound = false;

  @override
  void initState() {
    super.initState();
    _chargesPresenter = ChargesPresenter(this);
    _chargesPresenter.getCharges('X46959966');
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 20, 25, 0),
      child: _isLoading ? CustomProgressIndicatorWidget() : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Datos del centro',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
          Text('Centro en servicio: ${_currentJob.school}'),
          Text('Localidad: ${_currentJob.city}'),
          SizedBox(height: 20,),
          Text(
            'Datos de la plaza',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Divider(
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
          Text('Tipo: ${_currentJob.type}'),
          _currentJob.partTime ? Text('Media jornada: Sí') : Text('Media jornada: No'),
          Text('Cuerpo: ${_currentJob.body}'),
          Text('Función: ${_currentJob.function}'),
        ],
      ),
    );
  }

  @override
  void onLoadCurrentJobComplete(CurrentJob currentJob) {
    setState(() {
      _currentJob = currentJob;
      _isLoading = false;
    });
  }

  @override
  void onLoadCurrentJobError() {
    setState(() {
      _isLoading = false;
      _currentJobNotFound = true;
      _showErrorDialog();
    });
  }

  Future<void> _showErrorDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Atención'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Text('Se ha producido un error al recuperar su situación actual'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}