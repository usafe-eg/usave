import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/station_list_item.dart';

class StationPage extends StatefulWidget {

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {

  List<Map<String,dynamic>> stations=[{'station':'Abbas Al Akad','color':Colors.green,'numbersOfStudents':2},
    {'station':'Makram Ebeid','color':Colors.deepOrangeAccent,'numbersOfStudents':3},
    {'station':'7th District','color':Colors.lightBlue,'numbersOfStudents':1}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Padding(padding:EdgeInsets.only(top: 30,left: 20),
            child: Text('Stations',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
      ),
      body: Padding(padding: EdgeInsets.all(8),
        child: ListView.builder(itemCount: stations.length,
            itemBuilder: (context,index){
              return StationListItem(numberOfStudents: stations[index]['numbersOfStudents'],color: stations[index]['color'],station: stations[index]['station'],)
              ;}),
      ),
    );
  }
}
