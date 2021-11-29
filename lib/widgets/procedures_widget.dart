import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/contracts/procedures_view_contract.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/presenters/procedures_presenter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Text(AppLocalizations.of(context)!.warning),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.procedures_warning),
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