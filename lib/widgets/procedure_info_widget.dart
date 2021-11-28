import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/course_finished_model.dart';
import 'package:gestint/models/procedure_model.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';

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
              text: 'Trámite ${procedure.id}',
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
                    Text('Fecha de inicio:'),
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
                    Text('Fecha de fin:'),
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
                    Text('Resultados:'),
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

            },
            style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
            child: Container(
              alignment: Alignment.center,
              width: double.infinity,
              child: Text('Inicia el trámite'),
            )
          ) : ElevatedButton(
              onPressed: (){

              },
              //style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Text('Ver resultados'),
              )
          )
        ],
      ),
    );
  }
}