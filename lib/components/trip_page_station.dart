import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TripPageStation extends StatelessWidget {

  final Color color;
  final String station;
  final int stationNumber;
  final int numberOfStudents;
  final int numberOfStations;

  TripPageStation({this.color, this.station, this.stationNumber, this.numberOfStudents,this.numberOfStations});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      width: 80,
      child: Stack(
        children: <Widget>[
          Positioned(
              left: 120,
              child: Text('($stationNumber/$numberOfStations)',style: TextStyle(fontWeight: FontWeight.bold,color: color),)),
          Positioned(
              left: 180,
              child: Icon(Icons.brightness_1,size: 18,color: color)),
          Positioned(
              left: 220,
              child: Text(station,style: TextStyle(fontWeight: FontWeight.bold,color: color),)),
          Positioned(
            left: 220,
            top: 20,
            child: Row(
              children: <Widget>[
                Icon(Icons.person_outline,color: color),
                Text(numberOfStudents.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: color),)
                      ],
                    ),
          ),
          Positioned(
            top: 20,
            left: 188,
            child: Container(
              width: 2,
              height: 50,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
