import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:usave/models/station.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/station_list_item.dart';
import 'package:usave/components/pages_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class StationPage extends StatefulWidget {

  static const String id = 'StationPage';

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {

  List<Station> stationsList=[];
  String token;
  List data=[];
  Box box;

  Future<bool> getStations()async
  {
    await openBox();
    stationsList.clear();
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    try{
      final http.Response response=await http.get('$BASE_URL''stations',headers:headers);
    final Map<String,dynamic> responseData=json.decode(response.body);
    List<dynamic> stationsList = responseData["results"];
    await putData(stationsList);
//    for (var item in data) {
//      final stations = Station(
//        numOfStudents: item["numOfStudents"],
//        name: item["name"],
//      );
//      if (stations.numOfStudents!=null) stationsList.add(stations);
//    }
//    return stationsList;
    }
    catch(SocketException){
      print("No Internet Connection");
    }
    ///get the data from DB
    var myMap=box.toMap().values.toList();
    if(myMap.isEmpty)
    {
      data.add('empty');
    }
    else {
      data=myMap;
    }
    return Future.value(true);

  }

  Future putData(data)async
  {
    await box.clear();
    ///insert the data
    for(var d in data)
    {
      box.add(d);

    }
  }
  Future<void> updateData()async
  {
    stationsList.clear();

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    try{
      final http.Response response=await http.get('$BASE_URL''stations',headers:headers);
      final Map<String,dynamic> responseData=json.decode(response.body);
      List<dynamic> stationsList = responseData["results"];
      await putData(stationsList);
      setState(() {

      });
//      for (var item in membersList) {
//        final members = Member(
//          id: item["id"],
//          name: item["name"],
//        );
//        if (members.id!=null) membersList.add(members);
//      }
//      //return membersList;
    }
    catch(SocketException)
    {
      Toast.show('No Internet Connection', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
    }
  }

  Future openBox() async
  {
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box=await Hive.openBox('stations');
    return;
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
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mainbackground.png"),
              fit: BoxFit.cover,
            )),
        child: Padding(padding: EdgeInsets.all(8),
          child: FutureBuilder(
            future: getStations(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(data.contains('empty'))
                {
                  return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                }
                else{
                return RefreshIndicator(
                  onRefresh: updateData,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) => StationListItem(
                        name: data[index]['name'],
                        color: Colors.orange,
                        numOfStudents:data[index]['numOfStudents'],
                      )),
                );
              }}
              else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
