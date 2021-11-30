import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
            color: Color.fromARGB(255, 204, 7, 60),
            thickness: 2,
          ),
        ],
      ),
    );
  }
}