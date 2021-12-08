import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This widget shows a text with a colored underline, is used in many parts of the app

class UnderlinedTextWidget extends StatelessWidget {

  final String text;
  final double cellPadding;

  const UnderlinedTextWidget(
      {Key? key, required this.text, required this.cellPadding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(cellPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: TextStyle(fontWeight: FontWeight.bold),
            //textAlign:TextAlign.end,
          ),
          Divider(
            color: Theme.of(context).primaryColor,
            thickness: 2,
          ),
        ],
      ),
    );
  }
}