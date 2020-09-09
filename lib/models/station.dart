import 'package:flutter/material.dart';
import 'package:usave/models/member.dart';

class Station{
  final String id;
  final String name;
  final List<Member> members;
  final double lat,lng;

  Station(this.id, this.name, this.members, this.lat, this.lng);
}