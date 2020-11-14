import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/components/pages_header.dart';

class BusMembersPage extends StatefulWidget {

  static const String id = 'BusMembersPage';

  @override
  _BusMembersPageState createState() => _BusMembersPageState();
}

class _BusMembersPageState extends State<BusMembersPage> {

  List<Map<String,dynamic>> busMembers=[{'name':'Saif Mohamed','station':'Abbas Al Akad','color':Colors.green},
    {'name':'Sherif Ehab','station':'Abbas Al Akad','color':Colors.green}
  ,{'name':'Mohamed Mohsen','station':'Makram Ebeid','color':Colors.deepOrangeAccent},
    {'name':'Seif Mohamed','station':'Makram Ebeid','color':Colors.deepOrangeAccent},
    {'name':'Shady Ahmed','station':'7th District','color':Colors.lightBlue},
    {'name':'Mohamed Sabry','station':'7th District','color':Colors.lightBlue},
    {'name':'Gasser Ashraf','station':'7th District','color':Colors.lightBlue},
    {'name':'Mohamed Ahmed','station':'7th District','color':Colors.lightBlue},
    {'name':'Ahmed Mahmoud','station':'AinShams','color':Colors.lightBlue},
    {'name':'Ahmed Samir','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mohamed Samir','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mohamed Hassan','station':'AinShams','color':Colors.lightBlue},
    {'name':'Hassan Maher','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mostafa Hassan','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mohamed Salem','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mahmoud Asharf','station':'AinShams','color':Colors.lightBlue},
    {'name':'Mohamed Ali','station':'Abbasya','color':Colors.lightBlue},
    {'name':'Mahmoud Roshdy','station':'Abbasya','color':Colors.lightBlue},
    {'name':'Mostafa Hassan','station':'Abbasya','color':Colors.lightBlue},
    {'name':'Ahmed Raef','station':'Abbasya','color':Colors.lightBlue},
    {'name':'Mohamed Ashraf','station':'Abbasya','color':Colors.lightBlue},
    {'name':'Amr Mohamed','station':'Manshet ELBakry','color':Colors.lightBlue},
    {'name':'Beshoy Wagih','station':'Manshet ELBakry','color':Colors.lightBlue},
    {'name':'John Safwat','station':'Manshet ELBakry','color':Colors.lightBlue},
    {'name':'Abduallah Mostafa','station':'Manshet ELBakry','color':Colors.lightBlue},
    {'name':'Amr Mahmoud','station':'Manshet ELBakry','color':Colors.lightBlue},
    {'name':'Ahmed Gamal','station':'Zeiton','color':Colors.lightBlue},
    {'name':'Mostafa ElGnedy','station':'Zeiton','color':Colors.lightBlue},
    {'name':'Mohamed Wagih','station':'Zeiton','color':Colors.lightBlue},
    {'name':'Abdelrahman Hussien','station':'Zeiton','color':Colors.lightBlue},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          PagesHeader('Bus Members')],
        backgroundColor: mainColor,),
      body: Padding(padding: EdgeInsets.all(8),
      child: ListView.builder(itemCount: busMembers.length,
          itemBuilder: (context,index){
          return MemberListItem(name: busMembers[index]['name'],color: Colors.orange,station: busMembers[index]['station'],)
        ;}),
      ),
    );
  }
}
