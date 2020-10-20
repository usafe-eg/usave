import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripPageStation extends StatelessWidget {

  final Color color;
  final String station;
  final int stationNumber;
  final int numberOfStudents;

  TripPageStation({this.color, this.station, this.stationNumber, this.numberOfStudents});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('($stationNumber/6)',style: TextStyle(fontWeight: FontWeight.bold,color: color),),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.brightness_1,size: 18,color: color),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top:20.0),
                    child: Text(station,style: TextStyle(fontWeight: FontWeight.bold,color: color),),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.person_outline,color: color),
                      Text(numberOfStudents.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: color),)
                    ],
                  )
                ],
              )
            ],),),
          Container(
            width: 2,
            height: 50,
            color: color,
          ),
        ],
      );
  }
}
