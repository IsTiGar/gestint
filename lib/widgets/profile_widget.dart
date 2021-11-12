import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:gestint/models/worker_model.dart';

class ProfileWidget extends StatelessWidget {

  final Worker worker;

  ProfileWidget ({Key? key, required this.worker}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(worker.pictureURL),
          backgroundColor: Colors.cyanAccent,
        ),
        Text('${worker.firstName} ${worker.lastName1} ${worker.lastName2}'),
        Text(worker.emailAddress)
      ],
    );
  }
}