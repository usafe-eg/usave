import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:usave/models/station.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:usave/models/member.dart';

class SendApis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const String url='';
    Future<Map<String,dynamic>> authenticate(String email, String password)
    async {
      final Map<String,dynamic> authData ={
        'email':email,
        'password':password,
        'returnSecureToken':true,
      };
      http.Response response;
      response= await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json'},
      );
      final Map<String,dynamic> responseData=json.decode(response.body);
      String message='Something went wrong!';
      bool hasError=true;
      if(responseData.containsKey('token'))
      {
        hasError =false;
        message='Authentication succeeded';
        //_authenticatedUser =User(id: responseData['localId'], email: email, token: responseData['idToken']);
        final DateTime now=DateTime.now();
        final SharedPreferences prefs=await SharedPreferences.getInstance();
        prefs.setString('token', responseData['token']);
        //prefs.setString('userEmail',email);
        //prefs.setString('userId', responseData['localId']);
      }
      else if(responseData['error']['message']=='EMAIL_NOT_FOUND')
      {
        message='This mail was not found';
      }

      else if(responseData['error']['message']=='EMAIL_EXISTS')
      {
        message='This mail already exists';
      }
      else if(responseData['error']['message']=='INVALID_PASSWORD')
      {
        message='The password is invalid';
      }
      //_isLoading=false;
      //notifyListeners();
      return{'success':!hasError, 'message':message};
    }


      Future<bool> createStation(String id,String name,double lat,double lng,List<Member> members) async
    {
      final Map<String,dynamic> stationData ={
        'id':id,///from backend
        'name':name,
        'lat':lat,
        'lng':lng,
        'members':members
      };
      try {
        final http.Response response= await http.post(url, body: json.encode(stationData),
          headers: {'Content-Type': 'application/json'},);
        if(response.statusCode!=200 && response.statusCode!=201)
          {
            return false;
          }
        final Map<String, dynamic> responseData = json.decode(response.body);
        final Station newStation=Station(id, name, members, lat, lng);
        return true;
      }
      catch(error){
        return false;
    }
    }


    Future<bool> startEndTrip(String message) async{
      try {
        final http.Response response= await http.post(url, body: json.encode(message),
          headers: {'Content-Type': 'application/json'},);
        if(response.statusCode==200 && response.statusCode!=201)
        {
          return false;
        }
        final Map<String, dynamic> responseData = json.decode(response.body);
        return true;
      }
      catch(error){
        return false;
      }

    }


    Future locationApi(String stationId,double lng,double lat)async
    {
      final Map<String,dynamic> locationData ={
        'stationId':stationId,///from backend
        'lat':lat,
        'lng':lng,
      };
      final http.Response response= await http.post(url, body: json.encode(locationData),
        headers: {'Content-Type': 'application/json'},);
      if(response.statusCode==200)
        {
          final Map<String, dynamic> responseData = json.decode(response.body);
        }
    }

    return Container();
  }
}
