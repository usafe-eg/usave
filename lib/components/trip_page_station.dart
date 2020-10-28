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
    return Stack(
      alignment: AlignmentDirectional.center,
        children: <Widget>[
          Positioned(
            left: 148,
            child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('($stationNumber/$numberOfStations)',style: TextStyle(fontWeight: FontWeight.bold,color: color),),
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
                  /////person and the number
                  Row(
                    children: <Widget>[
                      Icon(Icons.person_outline,color: color),
                      Text(numberOfStudents.toString(),style: TextStyle(fontWeight: FontWeight.bold,color: color),)
                    ],
                  )
                ],
              )
            ],),
          ),
          Container(
            width: 2,
            height: 50,
            color: color,
          ),
        ],
      );
  }
}
