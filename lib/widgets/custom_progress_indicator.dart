import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomProgressIndicatorWidget extends StatelessWidget {
  const CustomProgressIndicatorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: Color.fromARGB(255, 204, 7, 60),
      ),
    );
  }
}