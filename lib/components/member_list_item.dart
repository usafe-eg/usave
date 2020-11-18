import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/utilities/constants.dart';

// ignore: must_be_immutable
class MemberListItem extends StatefulWidget {

   Color color;
   final String name;
   final String station;
   final StationMode stationMode;

  MemberListItem({this.color, this.name, this.station,this.stationMode});

  @override
  _MemberListItemState createState() => _MemberListItemState();
}

class _MemberListItemState extends State<MemberListItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        highlightColor:widget.stationMode==StationMode.Edit?mainColor:null,
        splashColor:widget.stationMode==StationMode.Edit?mainColor:null,
        onTap: (){
          if(widget.stationMode==StationMode.Edit)
            {
                setState(() {
                  widget.color==greyColor?widget.color=mainColor:widget.color=greyColor;
                });
            }
        },
        child: Card(
          elevation: 6,
          color: Colors.white70,
          child: Stack(
            children: <Widget>[
              Container(color: widget.color,height: 50,width: 10,),
              Positioned(
                left: 20,
                  top: 15,
                  child: Text(widget.name)
              ),
              Positioned(
                top: 15,
                left: 165,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(widget.station)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
