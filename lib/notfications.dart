import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:usave/pages/login_page.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializing();
  }
  void initializing()async{
    androidInitializationSettings=AndroidInitializationSettings('app_icon');
    iosInitializationSettings=IOSInitializationSettings(onDidReceiveLocalNotification:onDidReceiveLocalNotification );
    initializationSettings=InitializationSettings(androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }

  void _showNotifications()async
  {
    await notification();
  }

  void _showNotificationsAfterSeconds()async
  {
    await notificationAfterSec();
  }

  Future<void> notification()async
  {
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        'channelId', 'channelName', 'channelDescription',priority: Priority.High,importance: Importance.Max,ticker: 'test');
    IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.show(0, 'U-Safe Company', 'I hope it works', notificationDetails);
  }

  Future<void> notificationAfterSec()async
  {
    var timeDelayed=DateTime.now().add(Duration(seconds: 5));
    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
        'second channelId', 'second channelName', 'second channelDescription',priority: Priority.High,importance: Importance.Max,ticker: 'test');
    IOSNotificationDetails iosNotificationDetails=IOSNotificationDetails();
    NotificationDetails notificationDetails=NotificationDetails(androidNotificationDetails, iosNotificationDetails);
    await flutterLocalNotificationsPlugin.schedule(1, 'U-Safe Company', 'I hope it works',timeDelayed, notificationDetails);
  }

  Future onSelectNotification(String payLoad){
    if(payLoad!=null)
      {
        print(payLoad);
      }
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  Future onDidReceiveLocalNotification(int id,String title,String body,String payLoad)async
  {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
      CupertinoDialogAction(
          isDefaultAction: true,
          onPressed: (){
            print('');
          },
          child: Text('Okay'))
    ],);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(color:Colors.blue,onPressed: (){_showNotifications();},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('show Notification',style: TextStyle(fontSize: 20),),
                )),
            FlatButton(color:Colors.blue,onPressed: (){_showNotificationsAfterSeconds();},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('show Notification after few sec',style: TextStyle(fontSize: 20),),
                ))
          ],
        ),
      ),
    );
  }
}
