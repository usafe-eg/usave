import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/models/supervisor.dart';
import 'package:usave/pages/trip_page.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/pages/stations_page.dart';
import 'package:usave/pages/members_page.dart';
import 'package:usave/models/station_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardPage extends StatefulWidget {
  static const String id = 'DashboardPage';

  final String busNumber;
  final String agentName;
  final String userName;

  DashboardPage({this.busNumber, this.agentName, this.userName});

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
    setState(() {
      _stationMode=StationMode.Normal;
      Navigator.pushNamed(context, BusMembersPage.id);
    });
  }
  void _navigateToStations()
  {
    Navigator.pushNamed(context, StationPage.id);
  }
  void getToken()async
  {
      final SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.getString('token');
    }


  StationMode _stationMode;

  @override
  void initState(){
    super.initState();
    getToken();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PagesHeader(widget.userName)],
        backgroundColor: mainColor,),
    body: Container(
      color: Colors.grey[300],
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical:150,horizontal: 30),
          child: Column(
            children: <Widget>[
              Text(widget.agentName,style: TextStyle(fontSize: 15),),
              Padding(
                padding: const EdgeInsets.only(bottom:20.0),
                child: Text(widget.busNumber,style: TextStyle(fontSize: 15),),
              ),
              MainButton('START TRIP',mainColor,280,_startTrip),
              MainButton('BUS MEMBERS',mainColor,280,_navigateToBusMembers),
              MainButton('STATIONS',mainColor,280,_navigateToStations),
            ],
          ),
        ),
        ],
      ),
    ),
    );
  }
}
