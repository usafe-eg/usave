import 'package:flutter/material.dart';
import 'package:usave/pages/dashboard_page.dart';
import 'package:usave/pages/scan_page.dart';
import 'package:usave/pages/members_page.dart';
import 'package:usave/pages/stations_page.dart';
import 'package:usave/pages/trip_page.dart';
import 'package:usave/pages/trip_members_details_page.dart';
import 'package:usave/pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),

    routes: {
        LoginPage.id:(BuildContext context) => LoginPage(),
      DashboardPage.id:(BuildContext context) =>DashboardPage(),
      ScanStudentPage.id:(BuildContext context) =>ScanStudentPage(),
      BusMembersPage.id:(BuildContext context) =>BusMembersPage(),
      StationPage.id:(BuildContext context) =>StationPage(),
      TripPage.id:(BuildContext context) =>TripPage(),
      TripMembersDetailsPage.id:(BuildContext context) =>TripMembersDetailsPage(),
    },
    );
  }
}
