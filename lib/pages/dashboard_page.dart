import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/pages/trip_page.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/pages/stations_page.dart';
import 'package:usave/pages/members_page.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'DashboardPage';

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  void _startTrip()
  {
    Navigator.pushNamed(context, TripPage.id);
  }
  void _navigateToBusMembers()
  {
    Navigator.pushNamed(context, BusMembersPage.id);
  }
  void _navigateToStations()
  {
    Navigator.pushNamed(context, StationPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: <Widget>[
              PagesHeader('Ahmed Yamany')],
            backgroundColor: mainColor,),
        body: Container(
          color: Colors.grey[300],
          width: double.infinity,
          child: Column(
            children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 100,
//              color: mainColor,
//              child: Padding(
//                padding: const EdgeInsets.only(left:20,right:0,bottom:10,top:0,),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Column(children: <Widget>[
//                      SizedBox(height: 50,),
//                      Text('Ahmed Yamany',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
//                      fontSize: 20),),
//                      Text('Trip Supervisor',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
//                    ],),
//                  ],
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:150,horizontal: 30),
              child: Column(
                children: <Widget>[
                  Text('Modern International School (MIS)',style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Text('Bus no. 123456',style: TextStyle(fontSize: 20),),
                  ),
                  MainButton('START TRIP',mainColor,280,_startTrip),
                  MainButton('BUS MEMBERS',greyColor,280,_navigateToBusMembers),
                  MainButton('STATIONS',greyColor,280,_navigateToStations),
                ],
              ),
            ),
            ],
          ),
        ),
    ),
      );
  }
}
