import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:toast/toast.dart';
import 'package:usave/models/member.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:usave/components/pages_header.dart';
import 'package:http/http.dart'as http;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class BusMembersPage extends StatefulWidget {

  static const String id = 'BusMembersPage';

  @override
  _BusMembersPageState createState() => _BusMembersPageState();
}

class _BusMembersPageState extends State<BusMembersPage> {

  Box box;
  List<Member> membersList=[];
  String token;
  List data=[];
  Future<bool> getMembers()async
  {
    await openBox();
    membersList.clear();
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    try{
      final Response response=await http.get('$BASE_URL''students',headers:headers);
      final Map<String,dynamic> responseData=json.decode(response.body);
      List<dynamic> membersList = responseData["results"];
      await putData(membersList);
//      for (var item in membersList) {
//        final members = Member(
//          id: item["id"],
//          name: item["name"],
//        );
//        if (members.id!=null) membersList.add(members);
//      }
//      //return membersList;
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
    membersList.clear();

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    try{
      final Response response=await http.get('$BASE_URL''students',headers:headers);
      final Map<String,dynamic> responseData=json.decode(response.body);
      List<dynamic> membersList = responseData["results"];
      await putData(membersList);
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
    box=await Hive.openBox('data');
    return;
  }


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          PagesHeader('Bus Members')],
        backgroundColor: mainColor,),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mainbackground.png"),
              fit: BoxFit.cover,
            )),
        child: Padding(padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: getMembers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if(data.contains('empty'))
                {
                  return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                }
              else {
                return RefreshIndicator(
                  onRefresh:updateData,
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) =>
                          MemberListItem(
                            name: data[index]['name'],
                            color: Colors.orange,
                            station: 'station',
                            stationMode: StationMode.Normal,
                          )),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        ),
      ),
    );
  }
}
