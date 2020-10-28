import 'package:flutter/material.dart';

class StationListItem extends StatelessWidget {

  final Color color;
  final int numberOfStudents;
  final String station;

  StationListItem({this.color,this.station,this.numberOfStudents});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 6,
        color: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(color: color,height: 50,width: 10,),
            Positioned(
              top:15,
                left: 100,
                child: Text(station)),
            Positioned(
              left: 280,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Icon(Icons.person_outline),
                    Text(numberOfStudents.toString())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
