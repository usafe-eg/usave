import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/trip_page_station.dart';

class TripPage extends StatefulWidget {
  @override
  _TripPageState createState() => _TripPageState();
}

class _TripPageState extends State<TripPage> {


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
      // Add your onPressed code here!
    }, child: Icon(Icons.settings_overscan), backgroundColor: mainColor,
        ),
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Padding(padding:EdgeInsets.only(top: 30,left: 20),
            child: Text('Trip Page',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(5),
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text('Members'),
                      Text('30')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('In Bus'),
                      Text('20')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Absent'),
                      Text('5')
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Waiting'),
                      Text('5')
                    ],
                  )
                ],
              ),
            ),
          ),
        Expanded(
          flex: 6,
          child: ListView.builder(itemCount: stationsDetails.length,
              itemBuilder: (context,index){
                return TripPageStation(color: stationsDetails[index]['color'],station:stationsDetails[index]['station'],
                stationNumber: stationsDetails[index]['stationNumber'],numberOfStudents:stationsDetails[index]['numberOfStudents'] ,);
          }),
        ),
          Expanded(
            flex: 2,
              child: MainButton('END TRIP',Colors.grey)),
        ],
      ),
    );
  }
}

