import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/pages/station_reg_edit_page.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/pages_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:usave/models/station_mode.dart';
class StationPage extends StatefulWidget {

  static const String id = 'StationPage';

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  StationMode _stationMode;
  List stationsList=[];
  String token;
  Box box;
  List<Widget> ss=[];
bool ordering =false;

  Future<List> getStations()async
  {
      //await openBox();
      //stationsList.clear();
    if(!ordering) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token');

      final Map<String, String> headers = {
        "Content-Type": 'application/json',
        "Authorization": 'Bearer $token',
      };
      try {
        final http.Response response = await http.get(
            '$BASE_URL''stations', headers: headers);
        final Map<String, dynamic> responseData = json.decode(response.body);
        stationsList = responseData["results"];
        // await putData(stationsList);
//    for (var item in data) {
//      final stations = Station(
//        numOfStudents: item["numOfStudents"],
//        name: item["name"],
//      );
//      if (stations.numOfStudents!=null) stationsList.add(stations);
//    }
//    return stationsList;
      }
      catch (SocketException) {
        print("No Internet Connection");
      }

      ///get the data from DB
//    var myMap=box.toMap().values.toList();
//    if(myMap.isEmpty)
//    {
//      data.add('empty');
//    }
//    else {
//      data=myMap;
//    }
      return Future.value(stationsList);
    }
    else{
      return Future.value(stationsList);}
  }

//  Future putData(data)async
//  {
//    await box.clear();
//    ///insert the data
//    for(var d in data)
//    {
//      box.add(d);
//
//    }
//  }
//  Future<void> updateData()async
//  {
//    stationsList.clear();
//
//    final Map<String,String> headers ={
//      "Content-Type":'application/json',
//      "Authorization": 'Bearer $token',
//    };
//    try{
//      final http.Response response=await http.get('$BASE_URL''stations',headers:headers);
//      final Map<String,dynamic> responseData=json.decode(response.body);
//      List<dynamic> stationsList = responseData["results"];
//      await putData(stationsList);
//      setState(() {
//
//      });
////      for (var item in membersList) {
////        final members = Member(
////          id: item["id"],
////          name: item["name"],
////        );
////        if (members.id!=null) membersList.add(members);
////      }
////      //return membersList;
//    }
//    catch(SocketException)
//    {
//      Toast.show('No Internet Connection', context,duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
//    }
//  }
//
//  Future openBox() async
//  {
//    var dir= await getApplicationDocumentsDirectory();
//    Hive.init(dir.path);
//    box=await Hive.openBox('stations');
//    return;
//  }
  void _onReorder(oldIndex, newIndex) {
    setState(() {
      ordering=true;
    });
    if (newIndex > ss.length) newIndex = ss.length;
    if (oldIndex < newIndex) newIndex -= 1;

    setState((){
      var d=stationsList[oldIndex];
      stationsList.removeAt(oldIndex);
      stationsList.insert(newIndex, d);
      var item = ss[oldIndex];
      ss.removeAt(oldIndex);
      ss.insert(newIndex, item);
    });
  }

 List<Widget> getListItems()
  {
    ss.clear();
        for(int i=0;i<stationsList.length;i++)
      {
        ss.add(
            Padding(
              key:ValueKey(stationsList[i]['id']),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  splashColor: mainColor,
                  highlightColor: mainColor,
                  onTap: (){
                    setState(() {
                      _stationMode=StationMode.Edit;
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (BuildContext context) {
                        return StationRegEditPage(stationName: stationsList[i]['name'],);
                      })
                      );
                    });
                  },
                  child: Card(
                    elevation: 6,
                    color: Colors.white70,
                    child:Stack(
                      children: <Widget>[
                        Container(color: Colors.orange,height: 50,width: 10,),
                        Positioned(
                            top:15,
                            left: 20,
                            child: Text(stationsList[i]['name'])),
                        Positioned(
                          left: 190,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person_outline),
                                Text(stationsList[i]['numOfStudents'].toString())
                              ],
                            ),
                          ),
                        )
                      ],
                    ),),
                ),
              ),
            ));
      }
    return ss;
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
              builder:(context, snapshot) {
               if (snapshot.hasData) {
                   if(stationsList.isEmpty)
                {
                  return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                }
                else{
                  return ReorderableListView(children: getListItems(),onReorder:_onReorder
                  );
              }}
              else {
                return Center(child: CircularProgressIndicator());
    }
    },
      ),
    ),)
    );
  }
}
