import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/trip_page_station.dart';
import 'package:usave/components/trip_page_detail.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/pages/scan_page.dart';
import 'package:usave/pages/trip_members_details_page.dart';
import 'package:usave/models/station_mode.dart';

class TripPage extends StatefulWidget {
  static const String id = 'TripPage';

  @override
  _TripPageState createState() => _TripPageState();
}
class _TripPageState extends State<TripPage> {
  StationMode _stationMode;

  void _endTrip()
  {
    Navigator.pop(context);
  }
  List<Map<String,dynamic>> stationsDetails=[
    {'station':'Abbas Al Akad','color':Colors.blueGrey,'numberOfStudents':2},
    {'station':'Makram Ebeid','color':Colors.blueGrey,'numberOfStudents':3},
    {'station':'7th District','color':Colors.yellow[700],'numberOfStudents':4},
    {'station':'AinShams','color':Colors.black,'numberOfStudents':8},
    {'station':'Abbasya','color':Colors.black,'numberOfStudents':5},
    {'station':'Manshet ELBakry','color':Colors.black,'numberOfStudents':5},
    {'station':'Zeiton','color':Colors.black,'numberOfStudents':4},];

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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mainbackground.png"),
              fit: BoxFit.cover,
            )),
        child: Column(
          children: <Widget>[
            Card(
              borderOnForeground: true,
              margin: EdgeInsets.all(5),
              elevation: 8,
              child: InkWell(
                highlightColor: mainColor,
                splashColor: mainColor,
                onTap: (){
                  setState(() {
                    _stationMode=StationMode.Normal;
                    Navigator.pushNamed(context, TripMembersDetailsPage.id);
                  });

                },
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
                    stationNumber: index+1,
                      numberOfStudents:stationsDetails[index]['numberOfStudents'] ,numberOfStations: stationsDetails.length,);
              }),
            ),
          ),
            Expanded(
              flex: 1,
                child: MainButton('END TRIP',mainColor,170,_endTrip)),
          ],
        ),
      ),
    );
  }


}

