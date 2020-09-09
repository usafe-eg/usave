import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:usave/models/member.dart';
import 'package:usave/models/station.dart';


class APIsCommands extends StatefulWidget {
    static String url='https//usavesystems.com/members/json.example';

  @override
  _APIsCommandsState createState() => _APIsCommandsState();
}

class _APIsCommandsState extends State<APIsCommands> {
    List members=List<Member>();

    List stations=List<Station>();

    Map<String,dynamic> membersJsonResponse;

  Future<Map<String,dynamic>> fetchMembers() async{
      http.Response response=await http.get(APIsCommands.url);
      if (response.statusCode==200)
        {
           membersJsonResponse=jsonDecode(response.body);
        }
    return membersJsonResponse;
  }

    @override
  void initState() {
    fetchMembers();
    super.initState();
  }

  Widget build(BuildContext context) {
    //////////////////////////****** view members ******//////////////////////////
//    return SingleChildScrollView(
//      child: ListView.builder(
//          physics: NeverScrollableScrollPhysics(),
//          shrinkWrap: true,
//          itemCount: membersJsonResponse.length,
//          itemBuilder: (context,index){
//            return
//             // Text( memberName:membersJsonResponse[index]['name'],stationName: membersJsonResponse[index]['name'],)
//            ;}),
//    );


  }
}
