import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final String _buttonText;
  final Color _color;
  MainButton(this._buttonText,this._color);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            padding: const EdgeInsets.only(top:20.0,bottom: 18,left: 20,right: 20),
            child: ButtonTheme(
              minWidth: 280,
              height: 40,
              child: RaisedButton(
                  shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                      side:BorderSide.none),
                  onPressed: (){},textColor:Colors.white,color:_color,
                  child: Text(_buttonText,style: TextStyle(fontSize:25,fontWeight: FontWeight.w400),)),
            ),);
  }
}
