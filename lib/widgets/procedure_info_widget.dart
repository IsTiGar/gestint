import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/views/single_procedure_view.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProcedureInfoWidget extends StatelessWidget {

  final Procedure procedure;

  const ProcedureInfoWidget(
      {Key? key, required this.procedure})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              2: IntrinsicColumnWidth()// i want this one to take the rest available space
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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleProcedureView(procedureId: procedure.id,)));
            },
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(AppLocalizations.of(context)!.start_procedure),
            )
          ) : ElevatedButton(
              onPressed: (){

              },
              //style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
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