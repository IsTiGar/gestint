
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/course_model.dart';
import 'package:gestint/widgets/underlinedTextWidget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// This widget shows a single course info (dates, agency, etc.)
/// User can check some course info, admitted and waiting lists and subscribe to available courses

class CourseInfoWidget extends StatefulWidget{

  final Course course;

  const CourseInfoWidget(
      {Key? key, required this.course})
      : super(key: key);

  @override
  State<CourseInfoWidget> createState() => _CourseInfoWidgetState();

}

class _CourseInfoWidgetState extends State<CourseInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UnderlinedTextWidget(
              text: widget.course.title,
              cellPadding: 0,
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
                new TextSpan(text: '${AppLocalizations.of(context)!.start_data}: ', style: new TextStyle(fontWeight: FontWeight.bold)),
                new TextSpan(text: widget.course.startDate)
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
                new TextSpan(text: widget.course.endDate),
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
                new TextSpan(text: widget.course.agency)
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
                new TextSpan(text: widget.course.strategicLine)
              ],
            ),
          ),
          Container(
            child: Text(
              '${widget.course.hours} ${AppLocalizations.of(context)!.hours}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            alignment: Alignment.centerRight,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Info button
              ElevatedButton(
                style: ElevatedButton.styleFrom(),
                onPressed: () {
                  _showInfoDialog(widget.course.title, widget.course.description);
                },
                child: Text(AppLocalizations.of(context)!.info, style: TextStyle(fontSize: 14),),
              ),
              // Admitted and waiting List button
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.grey, onPrimary: Colors.black),
                onPressed: () {
                  _showListDialog(widget.course.admittedList, widget.course.waitingList);
                },
                child: Text(AppLocalizations.of(context)!.course_lists, style: TextStyle(fontSize: 14),),
              ),
              // Inscription button
              widget.course.available ? ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Color.fromARGB(255, 50, 129, 75)),
                onPressed: () {
                  _showSubscriptionDialog(widget.course.title);
                },
                child: Text(AppLocalizations.of(context)!.subscription, style: TextStyle(fontSize: 14),),
              ) : ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
                onPressed: () {
                  //TODO Register user in this course
                },
                child: Text(AppLocalizations.of(context)!.closed, style: TextStyle(fontSize: 14),),
              ),
            ],
          )
        ],
      ),
    );
  }

  // Show a list of admitted people in this course, only if course registration is closed, blank list otherwise
  Future<void> _showListDialog(List<String> admittedList, List<String> waitingList) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.course_lists),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.admitted),
              Divider(color: Theme.of(context).primaryColor,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: admittedList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text('${index+1}. ${admittedList[index]}');
                },
              ),
              SizedBox(height: 15,),
              Text(AppLocalizations.of(context)!.waiting),
              Divider(color: Theme.of(context).primaryColor,),
              ListView.builder(
                shrinkWrap: true,
                itemCount: waitingList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text('${index+1}. ${waitingList[index]}');
                },
              )
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

  // Show this course general information
  Future<void> _showInfoDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(message),
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

  // User must confirm the subscription to the course
  Future<void> _showSubscriptionDialog(String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(AppLocalizations.of(context)!.course_subscription_message),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text(AppLocalizations.of(context)!.cancel),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(AppLocalizations.of(context)!.confirm, style: TextStyle(color: Color.fromARGB(255, 50, 129, 75)),),
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