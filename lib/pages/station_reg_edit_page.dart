import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/pages/dashboard_page.dart';
import 'package:http/http.dart'as http;
import 'package:usave/models/member.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StationRegEditPage extends StatefulWidget {
  static const String id = 'StationRegEditPage';
  static List<int>studentsId=[];
  final String stationName;
  StationRegEditPage({this.stationName});

  @override
  _StationRegEditPageState createState() => _StationRegEditPageState();
}

class _StationRegEditPageState extends State<StationRegEditPage> {


  Future<void> _getCurrentStation()async{
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    isLocationServiceEnabled  = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    setState(() {
      latitude=position.latitude;
      longitude=position.longitude;
    });
//     await Geolocator.openAppSettings();
//     await Geolocator.openLocationSettings();
    print('${position.longitude} sssssssss');
  }
  List<Member> membersList=[];
  String token;
  Future<List<Member>> getMembers()async
  {
    membersList.clear();
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

    createNewStation(String name,double lat,double long,int busId,List<int>studentsId)async
    {
      Map <String,dynamic> authData = {
        'name': name,
        'lat':lat,
        'long':long,
        'busId':busId,
        'studentsId':studentsId,
      };
      final Map<String,String> headers ={
        "Content-Type":'application/json',
        "Authorization": 'Bearer $token',
      };
      final Response response=await http.post('$BASE_URL''stations',headers:headers,body:jsonEncode(authData));
      Map <String,dynamic>responseData;
      responseData = json.decode(response.body);
      print(authData);
      if (response.statusCode == 200) {
        if (responseData != null) {
          print('$responseData');
//        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
////            builder: (BuildContext context) => Gr()), (
////            Route<dynamic> route) => false);
        }
      }
    }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController stationController = new TextEditingController();
  final TextEditingController lngController = new TextEditingController();
  final TextEditingController latController = new TextEditingController();
  Position position;
  LocationPermission permission;
  bool isLocationServiceEnabled;
  double latitude;
  double longitude;
  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    _getCurrentStation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        actions: <Widget>[
          PagesHeader('Station regestration/edit'),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/mainbackground.png"),
              fit: BoxFit.cover,
            )),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Card(
                borderOnForeground: true,
                margin: EdgeInsets.all(5),
                elevation: 8,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 90,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                              left: 30, top: 20, child: Text('station name')),
                          Positioned(
                            left: 130,
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.text,
                                controller: stationController,
                                validator:(String value) {
                                  if (value.trim().startsWith(' ')) {
                                    return 'Valid Station Name Needed';
                                  }
                                },
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: widget.stationName==null?'':widget.stationName,
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Positioned(left: 30, top: 20, child: Text('LocLng')),
                          Positioned(
                            left: 130,
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: lngController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 15),
                                decoration: InputDecoration(
                                  filled: true,
                                  labelText:longitude==null?'Loading LocLng...':longitude.toString(),
                                  fillColor: Colors.white,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 70,
                      width: double.infinity,
                      child: Stack(
                        children: <Widget>[
                          Positioned(left: 30, top: 20, child: Text('LocLat')),
                          Positioned(
                            left: 130,
                            child: SizedBox(
                              width: 200,
                              child: TextFormField(
                                readOnly: true,
                                textAlign: TextAlign.center,
                                controller: latController,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'OpenSans',
                                    fontSize: 15),
                                decoration: InputDecoration(
                                  labelText:latitude==null?'Loading LocLat...':latitude.toString(),
                                  filled: true,
                                  fillColor: Colors.white,
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.red)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: FutureBuilder(
                    future: getMembers(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) => MemberListItem(
                              name: snapshot.data[index].name,
                              color: greyColor,
                              station:'station',
                              id:snapshot.data[index].id,
                              stationMode: StationMode.Edit,
                            ));
                      } else {
                        return Center(child: CircularProgressIndicator());
                      }
                    },
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: MainButton('Save', mainColor, 170, () async {
                    if(_formKey.currentState.validate()||widget.stationName!=null)
                    {
                      _formKey.currentState.save();
                      try{
                        await createNewStation(stationController.text==''?widget.stationName:stationController.text,
                            latitude,longitude,2,StationRegEditPage.studentsId);
                        //Navigator.pushNamed(context, DashboardPage.id);
                      }
                      catch(e)
                      {
                        print(e);
                      }
                    }
                  })),
            ],
          ),
        ),
      ),
    );
  }
}
