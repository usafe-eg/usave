import 'package:flutter/material.dart';

class StationListItem extends StatelessWidget {

  final Color color;
  final int numberOfStudents;
  final String station;

  StationListItem({this.color,this.station,this.numberOfStudents});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 6,
        color: Colors.white70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(color: color,height: 50,width: 10,),
            Text(station),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.person),
                  Text(numberOfStudents.toString())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
