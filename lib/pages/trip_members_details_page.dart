import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/components/pages_header.dart';

class TripMembersDetailsPage extends StatefulWidget {

  static const String id = 'TripMembersDetailsPage';

  @override
  _TripMembersDetailsPageState createState() => _TripMembersDetailsPageState();
}

class _TripMembersDetailsPageState extends State<TripMembersDetailsPage> {


  List<Map<String,dynamic>> busMembers=[{'name':'Saif Mohamed','station':'Abbas Al Akad','color':Colors.red},
    {'name':'Sherif Ehab','station':'Abbas Al Akad','color':Colors.green}
    ,{'name':'Mohamed Mohsen','station':'Makram Ebeid','color':Colors.green},
    {'name':'Seif Mohamed','station':'Makram Ebeid','color':Colors.green},
    {'name':'Shady Ahmed','station':'7th District','color':Colors.green},
    {'name':'Mohamed Sabry','station':'7th District','color':Colors.red},
    {'name':'Gasser Ashraf','station':'7th District','color':Colors.red},
    {'name':'Mohamed Ahmed','station':'7th District','color':Colors.green},
    {'name':'Ahmed Mahmoud','station':'AinShams','color':Colors.green},
    {'name':'Ahmed Samir','station':'AinShams','color':Colors.red},
    {'name':'Mohamed Samir','station':'AinShams','color':Colors.green},
    {'name':'Mohamed Hassan','station':'AinShams','color':Colors.green},
    {'name':'Hassan Maher','station':'AinShams','color':Colors.red},
    {'name':'Mostafa Hassan','station':'AinShams','color':Colors.orange},
    {'name':'Mohamed Salem','station':'AinShams','color':Colors.orange},
    {'name':'Mahmoud Asharf','station':'AinShams','color':Colors.orange},
    {'name':'Mohamed Ali','station':'Abbasya','color':Colors.orange},
    {'name':'Mahmoud Roshdy','station':'Abbasya','color':Colors.orange},
    {'name':'Mostafa Hassan','station':'Abbasya','color':Colors.orange},
    {'name':'Ahmed Raef','station':'Abbasya','color':Colors.orange},
    {'name':'Mohamed Ashraf','station':'Abbasya','color':Colors.orange},
    {'name':'Amr Mohamed','station':'Manshet ELBakry','color':Colors.orange},
    {'name':'Beshoy Wagih','station':'Manshet ELBakry','color':Colors.orange},
    {'name':'John Safwat','station':'Manshet ELBakry','color':Colors.orange},
    {'name':'Abduallah Mostafa','station':'Manshet ELBakry','color':Colors.orange},
    {'name':'Amr Mahmoud','station':'Manshet ELBakry','color':Colors.orange},
    {'name':'Ahmed Gamal','station':'Zeiton','color':Colors.orange},
    {'name':'Mostafa ElGnedy','station':'Zeiton','color':Colors.orange},
    {'name':'Mohamed Wagih','station':'Zeiton','color':Colors.orange},
    {'name':'Abdelrahman Hussien','station':'Zeiton','color':Colors.orange},];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          PagesHeader('Bus Members Details')],
        backgroundColor: mainColor,),
      body: Padding(padding: EdgeInsets.all(8),
        child: ListView.builder(itemCount: busMembers.length,
            itemBuilder: (context,index){
              return MemberListItem(name: busMembers[index]['name'],color: busMembers[index]['color'],station: busMembers[index]['station'],)
              ;}),
      ),
    );
  }
}
