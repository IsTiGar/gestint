
import 'package:flutter/material.dart';
import 'package:gestint/contracts/single_procedure_view_contract.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:gestint/presenters/single_procedure_presenter.dart';
import 'package:gestint/widgets/available_job_info_widget.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.job_selection)),
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
            child: UnderlinedTextWidget(text: AppLocalizations.of(context)!.long_press_message, cellPadding: 5,),
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
                  Text(AppLocalizations.of(context)!.reorder_jobs, style: TextStyle(color: Colors.white),),
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.click, style: TextStyle(color: Colors.white),),
                      SizedBox(width: 3,),
                      Icon(
                        Icons.send,
                        size: 20.0,
                        color: Colors.white,
                      ),
                      SizedBox(width: 3,),
                      Text(AppLocalizations.of(context)!.to_finalize, style: TextStyle(color: Colors.white),),
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
          title: Text(AppLocalizations.of(context)!.warning),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.job_warning),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.ok),
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