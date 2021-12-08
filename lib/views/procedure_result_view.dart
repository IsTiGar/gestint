
import 'package:flutter/material.dart';
import 'package:gestint/contracts/procedure_result_view_contract.dart';
import 'package:gestint/helpers/helper.dart';
import 'package:gestint/models/procedure_result_model.dart';
import 'package:gestint/presenters/procedure_results_presenter.dart';
import 'package:gestint/widgets/custom_progress_indicator.dart';
import 'package:gestint/widgets/procedure_result_info_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProcedureResultView extends StatefulWidget{

  final String procedureId;
  final Map<String, String> codeList;

  ProcedureResultView({Key? key, required this.procedureId, required this.codeList}) : super(key: key);

  @override
  State<ProcedureResultView> createState() => _ProcedureResultViewState();

}

class _ProcedureResultViewState extends State<ProcedureResultView> implements ProcedureResultViewContract {

  late ProcedureResultsPresenter _procedureResultPresenter;
  late List<ProcedureResult> _procedureResultList;
  bool _procedureResultNotFound = false;
  bool _isLoading = true;
  late Helper _helper;

  @override
  void initState() {
    super.initState();
    _helper = new Helper(context);
    _procedureResultPresenter = ProcedureResultsPresenter(this);
    _procedureResultPresenter.getProcedureResult(widget.procedureId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.job_selection)), //TODO cambiar texto
      body: Padding(
        padding: EdgeInsets.all(10),
        child: _isLoading ? CustomProgressIndicatorWidget() : _procedureResultNotFound? SizedBox.shrink() : ListView.builder(
          padding: const EdgeInsets.all(0),
          itemBuilder: (BuildContext context, int index) {
            return ProcedureResultInfoWidget(
              procedureResult: _procedureResultList[index],
              typeString: _helper.getTypeString(_procedureResultList[index].type),
              functionString: _helper.getFunctionString(_procedureResultList[index].function),
            );
          },
          itemCount: _procedureResultList.length,
        ),
      ),
    );
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
              Text(AppLocalizations.of(context)!.job_warning), //TODO
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

  /* This shows a loading indicator with shadowed background while
  the credentials are checked on the remote database */
  buildLoadingIndicator(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CustomProgressIndicatorWidget(),
          );
        });
  }

  @override
  void onLoadProcedureResultComplete(List<ProcedureResult> procedureResultList) {
    setState(() {
      _procedureResultList = procedureResultList;
      _isLoading = false;
    });
  }

  @override
  void onLoadProcedureResultError() {
    setState(() {
      _isLoading = false;
      _procedureResultNotFound = true;
      _showErrorDialog();
    });
  }

}