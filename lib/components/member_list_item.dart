import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberListItem extends StatelessWidget {

  final Color color;
  final String name;
  final String station;

  MemberListItem({this.color, this.name, this.station});

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
            Text(name),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  Text(station)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
