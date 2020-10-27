import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {

  final String _buttonText;
  final Color _color;
  final double _size;
  final Function _function;
  MainButton(this._buttonText,this._color,this._size,this._function);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
            padding: const EdgeInsets.only(top:20.0,bottom: 18,left: 20,right: 20),
            child: ButtonTheme(
              minWidth: _size,
              height: 40,
              child: RaisedButton(
                  shape:RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                      side:BorderSide.none),
                  onPressed:_function,textColor:Colors.white,color:_color,
                  child: Text(_buttonText,style: TextStyle(fontSize:25,fontWeight: FontWeight.w400),)),
            ),);
  }
}
