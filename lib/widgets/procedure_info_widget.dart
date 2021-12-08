import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/helpers/helper.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/views/procedure_result_view.dart';
import 'package:gestint/views/single_procedure_view.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows a list of past and present procedures
/// User can check past procedure results or register his own procedure to ask for a job

class ProcedureInfoWidget extends StatelessWidget {

  final Procedure procedure;

  ProcedureInfoWidget(
      {Key? key, required this.procedure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Helper _helper = new Helper(context);
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderlinedTextWidget(
              text: '${AppLocalizations.of(context)!.procedure} ${procedure.id}',
              cellPadding: 0,
          ),
          Text(
            procedure.description,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            defaultColumnWidth: IntrinsicColumnWidth(),
            columnWidths: {
              0: FlexColumnWidth(1),
              1: IntrinsicColumnWidth(),
              2: IntrinsicColumnWidth()
            },
            //border: TableBorder.all(),
            children: [
              TableRow(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/start_data_icon.png'),
                      height: 20,
                    ),
                    Text('${AppLocalizations.of(context)!.start_data}:'),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        procedure.startDate,
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ]
              ),
              TableRow(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/end_data_icon.png'),
                      height: 20,
                    ),
                    Text('${AppLocalizations.of(context)!.end_data}:'),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        procedure.endDate,
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ]
              ),
              TableRow(
                  children: [
                    Image(
                      image: AssetImage('assets/icons/results_data_icon.png'),
                      height: 20,
                    ),
                    Text('${AppLocalizations.of(context)!.results}:'),
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        procedure.resultsDate,
                        textAlign:TextAlign.end,
                      ),
                    ),
                  ]
              ),
            ]
          ),
          procedure.isActive ? ElevatedButton(
            onPressed: (){
              // Go to available job list selection
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleProcedureView(procedureId: procedure.id, codeList: _helper.getCodeList(),)));
            },
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(AppLocalizations.of(context)!.start_procedure),
            )
          ) : ElevatedButton(
              onPressed: (){
                // Go to this procedure result
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProcedureResultView(procedureId: procedure.id, codeList: _helper.getCodeList(),)));
              },
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text(AppLocalizations.of(context)!.see_results),
              )
          )
        ],
      ),
    );
  }
}