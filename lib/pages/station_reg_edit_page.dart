import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/components/station_list_item.dart';

class StationRegEditPage extends StatefulWidget {
  static const String id = 'StationRegEditPage';

  @override
  _StationRegEditPageState createState() => _StationRegEditPageState();
}

class _StationRegEditPageState extends State<StationRegEditPage> {
  List<Map<String,dynamic>> stations=[{'station':'Abbas Al Akad','color':Colors.green,'numbersOfStudents':2},
    {'station':'Makram Ebeid','color':Colors.deepOrangeAccent,'numbersOfStudents':3},
    {'station':'7th District','color':Colors.lightBlue,'numbersOfStudents':4},
    {'station':'AinShams','color':Colors.lightBlue,'numbersOfStudents':8},
    {'station':'Abbasya','color':Colors.lightBlue,'numbersOfStudents':5},
    {'station':'Manshet ELBakry','color':Colors.lightBlue,'numbersOfStudents':5},
    {'station':'Zeiton','color':Colors.lightBlue,'numbersOfStudents':4},];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController stationController = new TextEditingController();
  final TextEditingController lngController = new TextEditingController();
  final TextEditingController latController = new TextEditingController();

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
                    height: 70,
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
                              validator: (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Station Name Needed';
                                }
                              },
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'OpenSans',
                                  fontSize: 20),
                              decoration: InputDecoration(
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
                                  fontSize: 20),
                              decoration: InputDecoration(
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
                                  fontSize: 20),
                              decoration: InputDecoration(
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
                child: ListView.builder(itemCount: stations.length,
                    itemBuilder: (context,index){
                      return StationListItem(numberOfStudents: stations[index]['numbersOfStudents'],
                        color:greyColor,station: stations[index]['station'],)
                      ;}),
              ),
            ),
            Expanded(
                flex: 1,
                child: MainButton('Save', mainColor, 170, () {
                  if(_formKey.currentState.validate())
                    {
                      _formKey.currentState.save();
                      try{
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
