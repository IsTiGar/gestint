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
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SingleProcedureView(procedureId: procedure.id, codeList: getCodeList(context),)));
            },
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text(AppLocalizations.of(context)!.start_procedure),
            )
          ) : ElevatedButton(
              onPressed: (){
                // TODO
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

  Map<String, String> getCodeList(BuildContext context) {
    return {
      '001' : AppLocalizations.of(context)!.filo,
      '002' : AppLocalizations.of(context)!.greek,
      '003' : AppLocalizations.of(context)!.latin,
      '004' : AppLocalizations.of(context)!.cast,
      '005' : AppLocalizations.of(context)!.geo_hist,
      '006' : AppLocalizations.of(context)!.maths,
      '007' : AppLocalizations.of(context)!.fq,
      '008' : AppLocalizations.of(context)!.bio_geo,
      '009' : AppLocalizations.of(context)!.draw,
      '010' : AppLocalizations.of(context)!.french,
      '011' : AppLocalizations.of(context)!.english,
      '012' : AppLocalizations.of(context)!.german,
      '013' : AppLocalizations.of(context)!.music,
      '014' : AppLocalizations.of(context)!.economy,
      '015' : AppLocalizations.of(context)!.ef,
      '016' : AppLocalizations.of(context)!.technology,
      '021' : AppLocalizations.of(context)!.ccss,
      '022' : AppLocalizations.of(context)!.ccnn,
      '023' : AppLocalizations.of(context)!.maths,
      '024' : AppLocalizations.of(context)!.cast,
      '025' : AppLocalizations.of(context)!.english,
      '026' : AppLocalizations.of(context)!.french,
      '027' : AppLocalizations.of(context)!.ef,
      '028' : AppLocalizations.of(context)!.music,
      '101' : AppLocalizations.of(context)!.cooking,
      '102' : AppLocalizations.of(context)!.electronic,
      '103' : AppLocalizations.of(context)!.aesthetic,
      '104' : AppLocalizations.of(context)!.installs,
      '105' : AppLocalizations.of(context)!.vehicle,
      '106' : AppLocalizations.of(context)!.hair,
      '107' : AppLocalizations.of(context)!.administration,
      '108' : AppLocalizations.of(context)!.community_services,
      '201' : AppLocalizations.of(context)!.german,
      '202' : AppLocalizations.of(context)!.english,
      '203' : AppLocalizations.of(context)!.spanish_foreign,
      '204' : AppLocalizations.of(context)!.french,
    };
  }
}