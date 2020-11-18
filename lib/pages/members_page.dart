import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/components/pages_header.dart';

class BusMembersPage extends StatefulWidget {

  static const String id = 'BusMembersPage';

  @override
  _BusMembersPageState createState() => _BusMembersPageState();
}

class _BusMembersPageState extends State<BusMembersPage> {

  List<Map<String,dynamic>> busMembers=[{'name':'Saif Mohamed','station':'Abbas Al Akad'},
    {'name':'Sherif Ehab','station':'Abbas Al Akad'}
  ,{'name':'Mohamed Mohsen','station':'Makram Ebeid'},
    {'name':'Seif Mohamed','station':'Makram Ebeid'},
    {'name':'Shady Ahmed','station':'7th District'},
    {'name':'Mohamed Sabry','station':'7th District'},
    {'name':'Gasser Ashraf','station':'7th District'},
    {'name':'Mohamed Ahmed','station':'7th District'},
    {'name':'Ahmed Mahmoud','station':'AinShams'},
    {'name':'Ahmed Samir','station':'AinShams'},
    {'name':'Mohamed Samir','station':'AinShams'},
    {'name':'Mohamed Hassan','station':'AinShams'},
    {'name':'Hassan Maher','station':'AinShams'},
    {'name':'Mostafa Hassan','station':'AinShams'},
    {'name':'Mohamed Salem','station':'AinShams'},
    {'name':'Mahmoud Asharf','station':'AinShams'},
    {'name':'Mohamed Ali','station':'Abbasya'},
    {'name':'Mahmoud Roshdy','station':'Abbasya'},
    {'name':'Mostafa Hassan','station':'Abbasya'},
    {'name':'Ahmed Raef','station':'Abbasya'},
    {'name':'Mohamed Ashraf','station':'Abbasya'},
    {'name':'Amr Mohamed','station':'Manshet ELBakry'},
    {'name':'Beshoy Wagih','station':'Manshet ELBakry'},
    {'name':'John Safwat','station':'Manshet ELBakry'},
    {'name':'Abduallah Mostafa','station':'Manshet ELBakry'},
    {'name':'Amr Mahmoud','station':'Manshet ELBakry'},
    {'name':'Ahmed Gamal','station':'Zeiton'},
    {'name':'Mostafa ElGnedy','station':'Zeiton'},
    {'name':'Mohamed Wagih','station':'Zeiton'},
    {'name':'Abdelrahman Hussien','station':'Zeiton'},];

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
          return MemberListItem(name: busMembers[index]['name']
            ,color: Colors.orange,station: busMembers[index]['station'],stationMode: StationMode.Normal,)
        ;}),
      ),
    );
  }
}
