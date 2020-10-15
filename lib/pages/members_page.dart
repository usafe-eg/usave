import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';

class BusMembersPage extends StatefulWidget {

  @override
  _BusMembersPageState createState() => _BusMembersPageState();
}

class _BusMembersPageState extends State<BusMembersPage> {

  List<Map<String,dynamic>> busMembers=[{'name':'Saif Mohamed','station':'Abbas Al Akad','color':Colors.green},
    {'name':'Sherif Ehab','station':'Abbas Al Akad','color':Colors.green}
  ,{'name':'Mohamed Mohsen','station':'Makram Ebeid','color':Colors.deepOrangeAccent},
    {'name':'Seif Mohamed','station':'Makram Ebeid','color':Colors.deepOrangeAccent},
    {'name':'Shady Ahmed','station':'7th District','color':Colors.lightBlue}];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Padding(padding:EdgeInsets.only(top: 30,left: 20),
            child: Text('Bus Members',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
      ),
      body: Padding(padding: EdgeInsets.all(8),
      child: ListView.builder(itemCount: busMembers.length,
          itemBuilder: (context,index){
          return MemberListItem(name: busMembers[index]['name'],color: busMembers[index]['color'],station: busMembers[index]['station'],)
        ;}),
      ),
    );
  }
}
