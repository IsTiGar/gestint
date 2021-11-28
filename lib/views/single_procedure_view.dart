
import 'package:flutter/material.dart';
import 'package:gestint/contracts/single_procedure_view_contract.dart';
import 'package:gestint/contracts/worker_view_contract.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/models/worker_model.dart';
import 'package:gestint/presenters/single_procedure_presenter.dart';
import 'package:gestint/presenters/worker_presenter.dart';
import 'package:gestint/widgets/available_job_info_widget.dart';
import 'package:gestint/widgets/courses_finished_widget.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/payroll_widget.dart';
import 'package:gestint/widgets/personal_file_widget.dart';
import 'package:gestint/widgets/available_workers_widget.dart';
import 'package:gestint/widgets/contact_widget.dart';
import 'package:gestint/widgets/documents_widget.dart';
import 'package:gestint/widgets/maps_widget.dart';
import 'package:gestint/widgets/procedures_widget.dart';
import 'package:gestint/widgets/scale_widget.dart';
import 'package:gestint/widgets/profile_widget.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:gestint/widgets/welcome_widget.dart';

class SingleProcedureView extends StatefulWidget{

  final String procedureId;

  SingleProcedureView({Key? key, required this.procedureId}) : super(key: key);

  @override
  State<SingleProcedureView> createState() => _SingleProcedureViewState();

}

class _SingleProcedureViewState extends State<SingleProcedureView> implements SingleProcedureViewContract {

  late SingleProcedurePresenter _singleProcedurePresenter;
  late List<CurrentJob> _availableJobList;
  bool _singleProcedureNotFound = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _singleProcedurePresenter = SingleProcedurePresenter(this);
    _singleProcedurePresenter.getAvailableJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selección de plazas')),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _isLoading ? CustomProgressIndicatorWidget() : _singleProcedureNotFound? SizedBox.shrink() : ReorderableListView.builder(
          padding: const EdgeInsets.all(0),
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }
              final CurrentJob job = _availableJobList.removeAt(oldIndex);
              _availableJobList.insert(newIndex, job);
            });
          },
          header: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: UnderlinedTextWidget(text: 'Mantén pulsado el icono de la derecha para ordenar', cellPadding: 5,),
          ),
          itemBuilder: (BuildContext context, int index) {
            return AvailableJobInfoWidget(
                key: ValueKey(_availableJobList[index].id),
                job: _availableJobList[index]
            );
          },
          itemCount: _availableJobList.length,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Theme.of(context).primaryColor,
          child: new Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Coloca las plazas por orden de preferencia', style: TextStyle(color: Colors.white),),
                  Row(
                    children: [
                      Text('Pulsa', style: TextStyle(color: Colors.white),),
                      SizedBox(width: 3,),
                      Icon(
                        Icons.send,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3,),
                      Text('para finalizar', style: TextStyle(color: Colors.white),),
                    ],
                  )
                ],
              )
          )
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 50, 129, 75),
        elevation: 4.0,
        child: const Icon(
          Icons.send,
          size: 24.0,
          color: Colors.white,
        ),
        onPressed: () {
          //TODO ir a la pantalla de cursos
        },
      ),
    );
  }

  @override
  void onLoadSingleProcedureComplete(List<CurrentJob> availableJobList) {
    setState(() {
      _availableJobList = availableJobList;
      _isLoading = false;
    });
  }

  @override
  void onLoadSingleProcedureError() {
    setState(() {
      _isLoading = false;
      _singleProcedureNotFound = true;
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
              Text('Se ha producido un error al recuperar las plazas disponibles, disculpe las molestias y vuelva a intentarlo más tarde'),
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