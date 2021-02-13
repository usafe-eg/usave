import 'dart:convert';
import 'package:http/http.dart'as http;
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
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TripPage extends StatefulWidget {
  static const String id = 'TripPage';

  @override
  _TripPageState createState() => _TripPageState();
}
class _TripPageState extends State<TripPage> {
  StationMode _stationMode;

  List data=[];
  Box box;
  String token;
  bool arrive=true;

  void _endTrip()async
  {
    final Map<String,dynamic> authData ={"isArrive":arrive};
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');
    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
//      final http.Response response = await http.post('$BASE_URL''trips/start',body:jsonEncode(authData),headers:headers);
//      final Map<String,dynamic> responseData=json.decode(response.body);
//      print('${response.body}''ssssssssssss');
//      print('${response.statusCode}''ssssssssssss');
//      if(response.statusCode==200)
//      {
//      }
    Navigator.pop(context);
  }

  Future<bool> getStations()async
  {
    await openBox();
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
  Future openBox() async
  {
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box=await Hive.openBox('stations');
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStations();
  }
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
              child: FutureBuilder(
                future: getStations(),
                builder: (context, snapshot){
                  if(snapshot.hasData)
                    {
                      if(data.contains('empty'))
                        {
                          return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                        }
                      else{
                        return ListView.builder(itemCount: data.length,
                            itemBuilder: (context,index){
                              return TripPageStation(color: Colors.black,
                                station:data[index]['name'],
                                stationNumber: index+1,
                                numberOfStudents:data[index]['numOfStudents'] ,numberOfStations: data.length,);
                            });
                      }
                    }
                  else {
                    return Center(child: CircularProgressIndicator());
                  }
                }
              ),
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

