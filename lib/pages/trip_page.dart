import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/trip_page_station.dart';
import 'package:usave/components/trip_page_detail.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/pages/scan_page.dart';

class TripPage extends StatefulWidget {
  static const String id = 'TripPage';

  @override
  _TripPageState createState() => _TripPageState();
}
class _TripPageState extends State<TripPage> {

  void _endTrip()
  {
    Navigator.pop(context);
  }
  List<Map<String,dynamic>> stationsDetails=[
    {'station':'Abbas Al Akad','color':Colors.blueGrey,'numberOfStudents':2,'stationNumber':1},
    {'station':'Makram Ebeid','color':Colors.blueGrey,'numberOfStudents':3,'stationNumber':2},
    {'station':'7th District','color':Colors.yellow[700],'numberOfStudents':1,'stationNumber':3},
    {'station':'Station 4','color':Colors.black,'numberOfStudents':5,'stationNumber':4},
    {'station':'Station 5','color':Colors.black,'numberOfStudents':2,'stationNumber':5},
    {'station':'Final Station','color':Colors.black,'numberOfStudents':4,'stationNumber':6},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, ScanStudentPage.id);
      // Add your onPressed code here!
    }, child: Icon(Icons.settings_overscan), backgroundColor: mainColor,
        ),
      appBar: AppBar(
        actions: <Widget>[
      PagesHeader('Trip Page')],
        backgroundColor: mainColor,),
      body: Column(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, ScanStudentPage.id);
            },
            child: Card(
              margin: EdgeInsets.all(5),
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TripPageDetail('Members', 30),
                    TripPageDetail('In Bus', 20),
                    TripPageDetail('Absent', 5),
                    TripPageDetail('Waiting', 5),
                  ],
                ),
              ),
            ),
          ),
        Expanded(
          flex: 6,
          child: Padding(
            padding: const EdgeInsets.only(top:40.0),
            child: ListView.builder(itemCount: stationsDetails.length,
                itemBuilder: (context,index){
                  return TripPageStation(color: stationsDetails[index]['color'],
                    station:stationsDetails[index]['station'],
                  stationNumber: stationsDetails[index]['stationNumber'],
                    numberOfStudents:stationsDetails[index]['numberOfStudents'] ,);
            }),
          ),
        ),
          Expanded(
            flex: 1,
              child: MainButton('END TRIP',Colors.grey,220,_endTrip)),
        ],
      ),
    );
  }


}

