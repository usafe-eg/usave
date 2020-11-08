import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:usave/models/auth_mode.dart';
import 'package:usave/pages/dashboard_page.dart';

class LoginPage extends StatefulWidget {
  static const String id = 'LoginPage';
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  AuthMode _authMode = AuthMode.Login;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/slice-01.png"),
          fit: BoxFit.cover,
        )),

        child: Padding(
          padding: const EdgeInsets.only(top:200,right:15,left:15),
          child: Center(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical:20.0,horizontal: 40),
                      child: TextFormField(
                        scrollPadding: EdgeInsets.all(20),
                        validator: (String value) {
                          if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                        },
                        keyboardType: TextInputType.emailAddress,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(hintText: 'Enter Your Email',
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,

                        prefixIcon: Icon(Icons.mail_outline,color: Colors.white,)),
                      ),
                    ),
                    _authMode==AuthMode.Login?Padding(
                      padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 40),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.trim().isEmpty) {
                            return 'Password must not be empty';
                          }
                        },
                        obscureText: true,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(hintText: 'Enter Your Password',
                            fillColor: Colors.grey.withOpacity(0.2),
                            filled: true,
                            prefixIcon:Icon(Icons.lock_outline,color: Colors.white,))
                      ),
                    ):Container(),
                    MainButton(_authMode==AuthMode.Login?'LOGIN':'Recover', mainColor, 280, (){
                      if(_formKey.currentState.validate())
                        {
                          _formKey.currentState.save();
                          try {
                            if (_authMode == AuthMode.Recover) {
                            } else if (_authMode == AuthMode.Login) {
                                Navigator.pushNamed(context, DashboardPage.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                        }
                    }),
                    FlatButton(onPressed: (){
                      setState(() {
                        _authMode =
                        _authMode == AuthMode.Login ? AuthMode.Recover : AuthMode.Login;
                      });
                    },
                      textColor: Colors.white,
                      child: Text(_authMode==AuthMode.Login?'Forgot password?':'Login?',
                        style: TextStyle(fontSize: 18),),)
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
