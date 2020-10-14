import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              backgroundColor: mainColor,
              title: Padding(padding:EdgeInsets.only(top: 30,left: 20),
                  child: Text('Ahmed Yamany',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
            ),
          ),
        body: Container(
          color: Colors.grey[300],
          width: double.infinity,
          child: Column(
            children: <Widget>[
//            Container(
//              width: double.infinity,
//              height: 100,
//              color: mainColor,
//              child: Padding(
//                padding: const EdgeInsets.only(left:20,right:0,bottom:10,top:0,),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Column(children: <Widget>[
//                      SizedBox(height: 50,),
//                      Text('Ahmed Yamany',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,
//                      fontSize: 20),),
//                      Text('Trip Supervisor',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,),),
//                    ],),
//                  ],
//                ),
//              ),
//            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical:150,horizontal: 30),
              child: Column(
                children: <Widget>[
                  Text('Modern International School (MIS)',style: TextStyle(fontSize: 20),),
                  Padding(
                    padding: const EdgeInsets.only(bottom:20.0),
                    child: Text('Bus no. 123456',style: TextStyle(fontSize: 20),),
                  ),
                  MainButton('START TRIP',mainColor),
                  MainButton('BUS MEMBERS',greyColor),
                  MainButton('STATIONS',greyColor),
                ],
              ),
            ),
            ],
          ),
        ),
    ),
      );
  }
}
