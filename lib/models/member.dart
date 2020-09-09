import 'package:flutter/material.dart';

class Member{
 final String id;
 final String name;
 final String stationId;

 Member({this.id, this.name, this.stationId,});


 factory Member.fromJson(Map<String,dynamic> json)
  {
    return Member(id:json['id'].toString(),
                  name:json['name'].toString(),
                  stationId:json['stationId'].toString()
    );
  }
}