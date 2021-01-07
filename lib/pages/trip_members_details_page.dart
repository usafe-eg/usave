import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/components/pages_header.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class TripMembersDetailsPage extends StatefulWidget {

  static const String id = 'TripMembersDetailsPage';

  @override
  _TripMembersDetailsPageState createState() => _TripMembersDetailsPageState();
}

class _TripMembersDetailsPageState extends State<TripMembersDetailsPage> {

  List data=[];
  Box box;

  Future<bool> getMembers()async
  {
    await openBox();
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
  Future openBox() async
  {
    var dir= await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box=await Hive.openBox('students');
    return;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMembers();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          PagesHeader('Bus Members Details')],
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
            builder: (context,snapshot){
              if(snapshot.hasData)
                {
                  if(data.contains('empty'))
                    {
                      return Center(child: Text('No Data',style: TextStyle(fontSize: 24),));
                    }
                  else{
                    return ListView.builder(itemCount: data.length,
                        itemBuilder: (context,index){
                          return MemberListItem(name: data[index]['name'],color: Colors.black,
                            station: 'station',)
                          ;});
                  }}
              else{
                return Center(child: CircularProgressIndicator());
              }
            }
          ),
        ),
      ),
    );
  }
}
