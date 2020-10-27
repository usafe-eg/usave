import 'package:flutter/material.dart';

class PagesHeader extends StatelessWidget {

  final String pageName;

  PagesHeader(this.pageName);

  @override
  Widget build(BuildContext context) {
    return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/slice-02.png"),
                  fit: BoxFit.cover,
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(pageName,textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize:25,)),
            ));
  }
}
