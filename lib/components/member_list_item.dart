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
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Card(
        elevation: 6,
        color: Colors.white70,
        child: Stack(
          children: <Widget>[
            Container(color: color,height: 50,width: 10,),
            Positioned(
              left: 20,
                top: 15,
                child: Text(name)
            ),
            Positioned(
              top: 15,
              left: 165,
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
