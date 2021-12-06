import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/course_finished_model.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CourseFinishedInfoWidget extends StatelessWidget {

  final CourseFinished courseFinished;

  const CourseFinishedInfoWidget(
      {Key? key, required this.courseFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderlinedTextWidget(
              text: courseFinished.title,
              cellPadding: 0,
          ),
          Text(courseFinished.type),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: '${AppLocalizations.of(context)!.start_data}: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: courseFinished.startDate)
              ],
            ),
          ),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: '${AppLocalizations.of(context)!.end_data}: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: courseFinished.endDate),
              ],
            ),
          ),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: AppLocalizations.of(context)!.agency, style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: courseFinished.agency)
              ],
            ),
          ),
          RichText(
            text: new TextSpan(
              // Note: Styles for TextSpans must be explicitly defined.
              // Child text spans will inherit styles from parent
              style: new TextStyle(
                fontSize: 14.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                new TextSpan(text: AppLocalizations.of(context)!.strategic_line, style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: courseFinished.strategicLine)
              ],
            ),
          ),
          Container(
            child: Text(
              '${courseFinished.hours} ${AppLocalizations.of(context)!.hours}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
    );
  }
}