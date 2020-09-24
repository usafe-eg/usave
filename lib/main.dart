import 'package:flutter/material.dart';
import 'package:usave/notfications.dart';
import 'package:usave/path_provider.dart';
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
      home: NotificationPage(),
    );
  }
}
