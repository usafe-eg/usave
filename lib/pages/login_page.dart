import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/models/supervisor.dart';
import 'package:http/http.dart'as http;
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
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
   Supervisor supervisor;
  bool _isLoading = false;

  Future<void> authenticate(String email, String password)async
  {
    final Map<String,String> authData ={
      "email":email,
      "password":password,
    };
    final Map<String,String> headers ={
      "Content-Type":'application/json',
    };
    final http.Response response = await http.post('$BASE_URL''users/login',
        body: jsonEncode(authData), headers:headers);
    final Map<String,dynamic> responseData=json.decode(response.body);
    if (responseData.containsKey('token')) {
      final SharedPreferences prefs=await SharedPreferences.getInstance();
      prefs.setString('token', responseData['token']);
      prefs.setInt('busId', responseData['busId']);
      supervisor=new Supervisor(busNumber:responseData['busNumber'],userName:responseData['username'],agentName:responseData['agentName']);
      _isLoading=false;
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage(supervisor:supervisor)),
      );

    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/loginbackground.png"),
          fit: BoxFit.cover,
        )),

        child: _isLoading?Center(child: CircularProgressIndicator()):
        Padding(
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
                        controller: emailController,
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
                        controller: passwordController,
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
                        setState(() {
                          _isLoading=true;
                        });
                          _formKey.currentState.save();
                          try {
                            if (_authMode == AuthMode.Recover) {
                            } else if (_authMode == AuthMode.Login) {

                               authenticate(emailController.text, passwordController.text);

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
