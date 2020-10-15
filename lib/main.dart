import 'package:flutter/material.dart';
import 'package:usave/pages/dashboard_page.dart';
import 'package:usave/pages/scan_page.dart';
import 'package:usave/pages/members_page.dart';
import 'package:usave/pages/stations_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
         
        primarySwatch: Colors.blue,
      ),
      home: BusMembersPage(),
    );
  }
}
