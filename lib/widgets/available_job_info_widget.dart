import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/current_job_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows a single job info (school, dates, type (sustitución or vacante), etc.)
/// Is used in every row of the available jobs list

class AvailableJobInfoWidget extends StatelessWidget {

  final CurrentJob job;
  final String functionString;
  final String typeString;

  const AvailableJobInfoWidget(
      {Key? key, required this.job, required this.functionString, required this.typeString})
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
                      Text('${job.school} (${job.city})')
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
                      Text('${AppLocalizations.of(context)!.start}: ${job.startDate}'),
                      Icon(
                        Icons.event,
                        color: Colors.black,
                        size: 20.0,
                      ),
                      Text('${AppLocalizations.of(context)!.end}: ${job.endDate}'),
                    ],
                  )
                ],
              ),
              Icon(
                Icons.swap_vert,
                color: Theme.of(context).primaryColor,
                size: 30.0,
              ),
            ],
          ),
          Divider(color: Theme.of(context).primaryColor),
        ],
      )
    );
  }
}