import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/courses_finished_view_contract.dart';
import 'package:gestint/contracts/destinations_view_contract.dart';
import 'package:gestint/contracts/documents_view_contract.dart';
import 'package:gestint/contracts/procedures_view_contract.dart';
import 'package:gestint/models/course_finished_model.dart';
import 'package:gestint/models/destination_model.dart';
import 'package:gestint/models/document_model.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/presenters/courses_finished_presenter.dart';
import 'package:gestint/presenters/destinations_presenter.dart';
import 'package:gestint/presenters/documents_presenter.dart';
import 'package:gestint/presenters/procedures_presenter.dart';
import 'package:gestint/widgets/course_finished_info_widget.dart';

import 'custom_progress_indicator.dart';
import 'procedure_info_widget.dart';

class ProceduresWidget extends StatefulWidget {

  const ProceduresWidget({Key? key}) : super(key: key);

  @override
  State<ProceduresWidget> createState() => _ProceduresWidgetState();
}

class _ProceduresWidgetState extends State<ProceduresWidget> implements ProceduresViewContract {

  late ProceduresPresenter _proceduresPresenter;
  late List<Procedure> _procedureList;
  bool _isLoading = true;
  bool _proceduresNotFound = false;

  @override
  void initState() {
    super.initState();
    _proceduresPresenter = ProceduresPresenter(this);
    _proceduresPresenter.getProcedures();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: _isLoading ? CustomProgressIndicatorWidget() : _proceduresNotFound? SizedBox.shrink() : ListView.separated(
        padding: const EdgeInsets.all(8),
        itemCount: _procedureList.length,
        itemBuilder: (BuildContext context, int index) {
          return ProcedureInfoWidget(procedure: _procedureList[index]);
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  @override
  void onLoadProceduresComplete(List<Procedure> procedureList) {
    setState(() {
      _procedureList = procedureList;
      _proceduresNotFound = false;
      _isLoading = false;
    });
  }

  @override
  void onLoadProceduresError() {
    setState(() {
      _isLoading = false;
      _proceduresNotFound = true;
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
              Text('Se ha producido un error al recuperar los trámites, disculpe las molestias e inténtelo más tarde'),
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