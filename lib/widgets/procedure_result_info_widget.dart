import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gestint/models/procedure_result_model.dart';

class ProcedureResultInfoWidget extends StatelessWidget {

  final ProcedureResult procedureResult;
  final String functionString;
  final String typeString;

  const ProcedureResultInfoWidget(
      {Key? key, required this.procedureResult, required this.functionString, required this.typeString})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.group_outlined,
                        color: Colors.pinkAccent,
                        size: 20.0,
                      ),
                      Text(typeString)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.home,
                        color: Colors.cyan,
                        size: 20.0,
                      ),
                      Text('${procedureResult.school}')
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star,
                        color: Colors.purple,
                        size: 20.0,
                      ),
                      Text(functionString)
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: Colors.green,
                        size: 20.0,
                      ),
                      Text('${AppLocalizations.of(context)!.start}: ${procedureResult.startDate}'),
                      Icon(
                        Icons.event,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      Text('${AppLocalizations.of(context)!.end}: ${procedureResult.endDate}'),
                    ],
                  )
                ],
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColor),
        ],
      )
    );
  }
}