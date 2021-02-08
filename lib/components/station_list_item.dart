import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/pages/station_reg_edit_page.dart';
import 'package:usave/models/station_mode.dart';

class StationListItem extends StatefulWidget {

  final Color color;
  final int numOfStudents;
  final String name;
  final Key key;
  StationListItem({this.color,this.name,this.numOfStudents,this.key}): super(key: key);

  @override
  _StationListItemState createState() => _StationListItemState();
}

class _StationListItemState extends State<StationListItem> {

  StationMode _stationMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: InkWell(
        splashColor: mainColor,
        highlightColor: mainColor,
        onTap: (){
          setState(() {
            _stationMode=StationMode.Edit;
              Navigator.of(context)
               .push(MaterialPageRoute(builder: (BuildContext context) {
             return StationRegEditPage(stationName: widget.name,);
           })
           );
          });
        },
        child: Card(
          elevation: 6,
          color: Colors.white70,
          child: Stack(
            children: <Widget>[
              Container(color: widget.color,height: 50,width: 10,),
              Positioned(
                top:15,
                  left: 20,
                  child: Text(widget.name)),
              Positioned(
                left: 190,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.person_outline),
                      Text(widget.numOfStudents.toString())
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
