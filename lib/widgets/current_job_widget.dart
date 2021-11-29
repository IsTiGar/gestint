import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/current_job_view_contract.dart';
import 'package:gestint/contracts/personal_data_contract.dart';
import 'package:gestint/contracts/personal_data_view_contract.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/personal_data_model.dart';
import 'package:gestint/models/user.dart';
import 'package:gestint/presenters/current_job_presenter.dart';
import 'package:gestint/presenters/personal_file_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:provider/provider.dart';

class CurrentJobWidget extends StatefulWidget{

  CurrentJobWidget({Key? key}) : super(key: key);

  @override
  State<CurrentJobWidget> createState() => _CurrentJobWidgetState();

}

class _CurrentJobWidgetState extends State<CurrentJobWidget> implements CurrentJobViewContract {

  bool _isLoading = true;
  late CurrentJob _currentJob;
  late CurrentJobPresenter _currentJobPresenter;
  bool _currentJobNotFound = false;

  @override
  void initState() {
    super.initState();
    _currentJobPresenter = CurrentJobPresenter(this);
    _currentJobPresenter.getCurrentJob(Provider.of<User>(context, listen: false).getUserId());
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