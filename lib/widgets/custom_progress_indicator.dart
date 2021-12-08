import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// This widget shows a circular coloured loading indicator
/// Is used in many parts of the app

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}