import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/models/station.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/station_list_item.dart';
import 'package:usave/components/pages_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class StationPage extends StatefulWidget {

  static const String id = 'StationPage';

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {



  List<Station> stationsList=[];
  String token;
  Future<List<Station>> getStations()async
  {
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    final http.Response response=await http.get('$BASE_URL''stations',headers:headers);
    final Map<String,dynamic> responseData=json.decode(response.body);
    List<dynamic> data = responseData["results"];
    for (var item in data) {
      final stations = Station(
        numOfStudents: item["numOfStudents"],
        name: item["name"],
      );
      if (stations.numOfStudents!=null) stationsList.add(stations);
    }
    return stationsList;

  }
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PagesHeader('Stations')],
        backgroundColor: mainColor,),
      body: Padding(padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: getStations(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) => StationListItem(
                    name: snapshot.data[index].name,
                    color: Colors.orange,
                    numOfStudents:snapshot.data[index].numOfStudents,
                  ));
            } else {
              return ModalProgressHUD(
                  inAsyncCall: true,
                  child: Container(child: Center(child: Text("Loading....."))));
            }
          },
        ),
      ),
    );
  }
}
