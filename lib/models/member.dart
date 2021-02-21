class Member{
 final int id;
 final String name;
 final String station;
 Member({this.id, this.name,this.station});


// factory Member.fromJson(Map<String,dynamic> json)
//  {
//    return Member(id:json['id'].toString(),
//                  name:json['name'].toString(),
//                  stationId:json['stationId'].toString()
//    );
//  }
}