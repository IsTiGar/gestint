import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/available_workers_view_contract.dart';
import 'package:gestint/models/worker_full_model.dart';
import 'package:gestint/presenters/available_workers_presenter.dart';

import 'custom_progress_indicator.dart';

class AvailableWorkersWidget extends StatefulWidget {
  const AvailableWorkersWidget({Key? key}) : super(key: key);

  @override
  State<AvailableWorkersWidget> createState() => _AvailableWorkersWidgetState();
  }

  class _AvailableWorkersWidgetState extends State<AvailableWorkersWidget> implements AvailableWorkersViewContract {

  late AvailableWorkersPresenter _availableWorkersPresenter;

  late List<WorkerFull> _availableWorkersList;
  bool _isLoading = false;
  bool _availableWorkersNotFound = true;

  String? _bodyValue;
  String? _functionValue;
  late String? _functionSelected;
  final _bodyList = <String>['Primaria','Secundaria', 'Formación profesional', 'Escuela oficial de idiomas'];
  final _priFunctionList = <String>[
    '021 Ciencias sociales',
    '022 Ciencias de la naturaleza',
    '023 Matemáticas',
    '024 Lengua castellana y literatura',
    '025 Inglés',
    '026 Francés',
    '027 Educació física',
    '028 Música',
  ];
  final _secFunctionList = <String>[
    '001 Filosofia',
    '002 Griego',
    '003 Latín',
    '004 Lengua castellana y literatura',
    '005 Geografia e historia',
    '006 Matemáticas',
    '007 Física y química',
    '008 Biología y geología',
    '009 Dibujo',
    '010 Francés',
    '011 Inglés',
    '012 Alemán',
    '013 Música',
    '014 Economía',
    '015 Educació Física',
    '016 Tecnología',
  ];
  final _fpFunctionList = <String>[
    '101 Cocina y pastelería',
    '102 Equipos electrónicos',
    '103 Estética',
    '104 Instalaciones electrotécnicas',
    '105 Mantenimiento de vehículos',
    '106 Peluquería',
    '107 Gestión administrativa',
    '108 Servicios a la comunidad',
  ];
  final _eoiFunctionList = <String>[
    '201 Alemán',
    '202 Inglés',
    '203 Español para estranjeros',
    '204 Francés',
  ];

  @override
  void initState() {
    super.initState();
    _availableWorkersPresenter = AvailableWorkersPresenter(this);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15),
      child: Column(
        children: [
          DropdownButton(
            isExpanded: true,
            value: _bodyValue,
            hint: Text('Selecciona un cuerpo'),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            //style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor
            ),
            onChanged: (String? newValue) {
              setState(() {
                _bodyValue = newValue!;
                _functionValue = null;
              });
            },
            items: _bodyList
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
          DropdownButton<String>(
            isExpanded: true,
            value: _functionValue,
            hint: Text('Selecciona una función'),
            icon: const Icon(Icons.arrow_drop_down),
            iconSize: 24,
            elevation: 16,
            //style: const TextStyle(color: Colors.deepPurple),
            underline: Container(
                height: 2,
                color: Theme.of(context).primaryColor
            ),
            onChanged: (String? newValue) {
              setState(() {
                _isLoading = true;
                _functionValue = newValue!;
              });
            },
            items: getFunctionList()
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          SizedBox(height: 10,),
          ElevatedButton(
            onPressed: () {
              // TODO asegurarme que no son null
              _availableWorkersPresenter.getAvailableWorkers(getBodyCode(_bodyValue!), getFunctionCode(_functionValue!));
              setState(() {
                _isLoading = true;
              });
            },
            child: Text('MOSTRAR'),
          ),
          _isLoading ? CustomProgressIndicatorWidget() : _availableWorkersNotFound? SizedBox.shrink() : ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: _availableWorkersList.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                trailing: Text(_availableWorkersList[index].score.toStringAsFixed(3)),
                title: Text(
                  '${_availableWorkersList[index].lastName1} ${_availableWorkersList[index].lastName2}, ${_availableWorkersList[index].firstName}',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  //textAlign:TextAlign.end,
                ),
                subtitle: Text(
                  _availableWorkersList[index].trained ? 'Tutorizado: Sí' : 'Tutorizado: No',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                  ),
                  //textAlign:TextAlign.end,
                ),
                dense: false,
              );
            },
            separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ]
      ),
    );
  }

  String getBodyCode(String body) {
    String code = '0';
    switch (body) {
      case 'Primaria':
        code = '058';
        break;
      case 'Secundaria':
        code = '059';
        break;
      case 'Formación profesional':
        code = '060';
        break;
      case 'Escuela oficial de idiomas':
        code = '061';
        break;
    }
    return code;
  }

  String getFunctionCode(String function) {
    return function.substring(0, 2); // returns first 3 characters (the code)
  }

  List<String> getFunctionList() {
    List<String>? _functionList;
    switch (_bodyValue) {
      case 'Primaria':
        _functionList = _priFunctionList;
        break;
      case 'Secundaria':
        _functionList = _secFunctionList;
        break;
      case 'Formación profesional':
        _functionList = _fpFunctionList;
        break;
      case 'Escuela oficial de idiomas':
        _functionList = _eoiFunctionList;
        break;
      default: _functionList = _priFunctionList;
        break;
    }
    return _functionList;
  }

  @override
  void onLoadAvailableWorkersComplete(List<WorkerFull> availableWorkersList) {
    setState(() {
      _availableWorkersList = availableWorkersList;
      _availableWorkersNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadAvailableWorkersError() {
    setState(() {
      _isLoading = false;
      _availableWorkersNotFound = true;
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
              Text('Se ha producido un error al acceder al listado'),
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