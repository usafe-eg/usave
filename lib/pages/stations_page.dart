import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/station_list_item.dart';
import 'package:usave/components/pages_header.dart';

class StationPage extends StatefulWidget {

  static const String id = 'StationPage';

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {

  List<Map<String,dynamic>> stations=[{'station':'Abbas Al Akad','numbersOfStudents':2},
    {'station':'Makram Ebeid','numbersOfStudents':3},
    {'station':'7th District','numbersOfStudents':4},
    {'station':'AinShams','numbersOfStudents':8},
    {'station':'Abbasya','numbersOfStudents':5},
    {'station':'Manshet ELBakry','numbersOfStudents':5},
    {'station':'Zeiton','numbersOfStudents':4},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PagesHeader('Stations')],
        backgroundColor: mainColor,),
      body: Padding(padding: EdgeInsets.all(8),
        child: ListView.builder(itemCount: stations.length,
            itemBuilder: (context,index){
              return StationListItem(numberOfStudents: stations[index]['numbersOfStudents'],
                color:Colors.orange,station: stations[index]['station'],)
              ;}),
      ),
    );
  }
}
