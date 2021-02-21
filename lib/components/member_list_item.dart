import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/models/student_mode.dart';
import 'package:usave/pages/stations_page.dart';
import 'package:usave/pages/station_reg_edit_page.dart';
import 'package:usave/utilities/constants.dart';

// ignore: must_be_immutable
class MemberListItem extends StatefulWidget {

   Color color;
   final String name;
   final String station;
   final StationMode stationMode;
   final int id;
   final StudentMode studentMode;

  MemberListItem({this.color, this.name, this.station,this.stationMode,this.id,this.studentMode});

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
                  if(widget.color==greyColor)
                    {
                      widget.color=mainColor;
                      StationRegEditPage.studentsId.add(widget.id);
                    }
                  else {
                    widget.color=greyColor;
                    StationRegEditPage.studentsId.remove(widget.id);
                  }

                });
            }
          if(widget.studentMode==StudentMode.Update)
            {
              showModalBottomSheet(context: context,
                  builder:(BuildContext context)=> StationPage(stationMode: StationMode.Normal,
                    studentName:widget.name,color: Colors.grey,studentId:widget.id,));
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
