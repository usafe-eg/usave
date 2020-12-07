import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:usave/models/member.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:usave/components/pages_header.dart';
import 'package:http/http.dart'as http;

class BusMembersPage extends StatefulWidget {

  static const String id = 'BusMembersPage';

  @override
  _BusMembersPageState createState() => _BusMembersPageState();
}

class _BusMembersPageState extends State<BusMembersPage> {

  List<Map<String,dynamic>> busMembers=[
    {'name':'Saif Mohamed','station':'Abbas Al Akad'},
    {'name':'Sherif Ehab','station':'Abbas Al Akad'},
    {'name':'Mohamed Mohsen','station':'Makram Ebeid'},
    {'name':'Seif Mohamed','station':'Makram Ebeid'},
    {'name':'Shady Ahmed','station':'7th District'},
    {'name':'Mohamed Sabry','station':'7th District'},
    {'name':'Gasser Ashraf','station':'7th District'},];

  List<Member> membersList=[];
  String token;
  Future<List<Member>> getMembers()async
  {
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');

    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
    final Response response=await http.get('$BASE_URL''students',headers:headers);
    final Map<String,dynamic> responseData=json.decode(response.body);
    List<dynamic> data = responseData["results"];
    for (var item in data) {
      final members = Member(
        id: item["id"],
        name: item["name"],
      );
      if (members.id!=null) membersList.add(members);
    }
    return membersList;

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
      body: Padding(padding: EdgeInsets.all(8),
      child: FutureBuilder(
        future: getMembers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => MemberListItem(
                  name: snapshot.data[index].name,
                  color: Colors.orange,
                  station: busMembers[index]['station'],
                  stationMode: StationMode.Normal,
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
