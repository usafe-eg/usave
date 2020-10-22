import 'package:flutter/material.dart';

class TripPageDetail extends StatelessWidget {

  final String name;
  final int number;

  TripPageDetail(this.name, this.number);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(name),
        Text(number.toString())
      ],
    );
  }
}
