import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:geolocator/geolocator.dart';
import 'package:usave/components/member_list_item.dart';
import 'package:usave/models/station_mode.dart';
import 'package:usave/pages/dashboard_page.dart';

class StationRegEditPage extends StatefulWidget {
  static const String id = 'StationRegEditPage';
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


  List<Map<String,dynamic>> busMembers=[
    {'name':'Saif Mohamed','station':'Abbas Al Akad'},
    {'name':'Sherif Ehab','station':'Abbas Al Akad'},
    {'name':'Mohamed Mohsen','station':'Makram Ebeid'},
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
      body: Form(
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
                                if (value.trim().isEmpty) {
                                  return 'Station Name Needed';
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
                child: ListView.builder(itemCount: busMembers.length,
                    itemBuilder: (context,index){
                      return MemberListItem(name: busMembers[index]['name'],
                        color:greyColor,station: busMembers[index]['station'],stationMode:StationMode.Edit,)
                      ;}),
              ),
            ),
            Expanded(
                flex: 1,
                child: MainButton('Save', mainColor, 170, () {
                  if(_formKey.currentState.validate()||widget.stationName!=null)
                    {
                      _formKey.currentState.save();
                      try{
                        Navigator.pushNamed(context, DashboardPage.id);


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
    );
  }
}
