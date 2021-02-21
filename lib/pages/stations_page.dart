import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/pages/station_reg_edit_page.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/pages_header.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
import 'package:toast/toast.dart';
import 'package:hive/hive.dart';
import 'package:usave/models/station_mode.dart';
import 'package:path_provider/path_provider.dart';

// ignore: must_be_immutable
class StationPage extends StatefulWidget {

  static const String id = 'StationPage';
   StationMode stationMode;
   String studentName;
   Color color;
   int studentId;

  StationPage({this.stationMode,this.studentName,this.color,this.studentId});

  @override
  _StationPageState createState() => _StationPageState();
}

class _StationPageState extends State<StationPage> {
  List stationsList=[];
  String token;
  Box box;
  List<Widget> ss=[];
  bool ordering =false;
  var myMap;
   bool code=false;
  Future<List> getStations()async
  {
    await openBox();
    myMap=box.toMap().values.toList();
    if(!ordering) {
      if (myMap.isEmpty || myMap.contains('empty')) {
        stationsList.clear();
        myMap.clear();
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
          myMap = stationsList;
          await putData(myMap);
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
        if (myMap.isEmpty) {
          myMap.add('empty');
        }
        return Future.value(myMap);
      }
      else {
        return Future.value(myMap);
      }
    }
   else if(ordering) {

  return Future.value(myMap);
  }
  }
  Future updateStudentStation(int id,stationId)async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    final Map<String,dynamic> authData ={
      "newStationId":stationId,
    };
    final Map<String, String> headers = {
      "Content-Type": 'application/json',
      "Authorization": 'Bearer $token',
    };
    try {
      final http.Response response = await http.put(
          '$BASE_URL''students/$id/updateStation',body: jsonEncode(authData),headers: headers);
      if(response.statusCode==200)
        {
          setState(() {code=true;});
        }
      else
        {
          setState(() {code=false;});
        }

    }
    catch (SocketException) {
      Toast.show("Failed to update StudentStation",context);
    }
  }
  Future putData(data)async
  {
    await box.clear();

    ///insert the data
    for (var d in data) {
      box.add(d);
    }
  }
  Future<void> updateData()async
  {
    stationsList.clear();
    myMap.clear();
    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    try{
      final http.Response response=await http.get('$BASE_URL''stations',headers:headers);
      final Map<String,dynamic> responseData=json.decode(response.body);
      List<dynamic> stationsList = responseData["results"];
      myMap=stationsList;
      await putData(myMap);
      getListItems();
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
  void _onReorder(oldIndex, newIndex) async{
    setState(() {
      ordering=true;
    });
    if (newIndex > ss.length) newIndex = ss.length;
    if (oldIndex < newIndex) newIndex -= 1;

    setState((){
      var d=myMap[oldIndex];
      myMap.removeAt(oldIndex);
      myMap.insert(newIndex, d);
      var item = ss[oldIndex];
      ss.removeAt(oldIndex);
      ss.insert(newIndex, item);
    });
    await putData(myMap);
  }

 List<Widget> getListItems()
  {
    ss.clear();
        for(int i=0;i<myMap.length;i++)
      {
        ss.add(
            Padding(
              key:ValueKey(myMap[i]['id']),
              padding: EdgeInsets.symmetric(vertical: 8),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: InkWell(
                  splashColor: mainColor,
                  highlightColor: mainColor,
                  onTap: (){
                    setState((){
                      if(widget.stationMode==StationMode.Normal)
                        {
                           updateStudentStation(widget.studentId,myMap[i]['id']);
                           Toast.show(code==true?'updated successfully':'update Failed',context,
                               duration:Toast.LENGTH_LONG);
                           Navigator.pop(context);
                        }
                      else{

                        widget.stationMode=StationMode.Edit;
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (BuildContext context) {
                          return StationRegEditPage(stationName: myMap[i]['name'],stationOrder:i+1,);
                        })
                        );
                      }
                    });
                  },
                  child: Card(
                    elevation: 6,
                    color: Colors.white70,
                    child:Stack(
                      children: <Widget>[
                        Container(color:widget.color,height: 50,width: 10,),
                        Positioned(
                            top:15,
                            left: 20,
                            child: Text(myMap[i]['name'])),
                        Positioned(
                          left: 190,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.person_outline),
                                Text(myMap[i]['numOfStudents'].toString())
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
          PagesHeader(widget.studentName==null?'Stations':'Edit ${widget.studentName} Station')],
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
                   if(myMap.isEmpty)
                {
                  return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                }
                else{
                  return RefreshIndicator(
                    onRefresh: updateData,
                    child: ReorderableListView(children: getListItems(),onReorder:_onReorder),
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
