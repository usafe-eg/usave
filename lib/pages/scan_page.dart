import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';
import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';

class ScanStudentPage  extends StatefulWidget {

  static const String id = 'ScanStudentPage';

  @override
  _ScanStudentPageState createState() => _ScanStudentPageState();
}

class _ScanStudentPageState extends State<ScanStudentPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  var qrText = "";
  var flashState = flashOn;
  String token;
  QRViewController controller;

  void _endScanning()
  {
    Navigator.pop(context);
  }
  void showToast(String msg, {int duration, int gravity}) {
    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
   _scanStudent(int studentId,tripId )async
  {
    final Map<String,dynamic> authData ={"studentId":studentId,"tripId":tripId};
    final SharedPreferences prefs=await SharedPreferences.getInstance();
    token=prefs.getString('token');
    final Map<String,String> headers ={
      "Content-Type":'application/json',
      "Authorization": 'Bearer $token',
    };
      final http.Response response = await http.post('$BASE_URL''students/scan',body:jsonEncode(authData),headers:headers);
      final Map<String,dynamic> responseData=json.decode(response.body);
      print('${response.statusCode}''ssssssssssss');
      if(response.statusCode==400)
      {
        print('${response.body}''ssssssssssss');
      }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          PagesHeader('Scan Student Data')],
        backgroundColor: mainColor,),
      body: Column(
        children: <Widget>[
//                    IconButton(
//            icon:flashState==flashOff ? Icon(Icons.flash_off):Icon(Icons.flash_on),
//            onPressed: () {
//              if (controller != null) {
//                controller.toggleFlash();
//                if (_isFlashOn(flashState)) {
//                  setState(() {
//                    flashState = flashOff;
//                  });
//                } else {
//                  setState(() {
//                    flashState = flashOn;
//                  });
//                }
//              }
//            },
//          ),
          Expanded(
            flex: 6,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: mainColor,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          MainButton('Cancel',mainColor,280,_endScanning),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller)async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      if(scanData!=qrText)
        {
          setState(()async {
            qrText = scanData;
            showToast(qrText, duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM);
            await  _scanStudent(5,12);
            //int.parse(qrText)
          });
          final play =AudioCache();
          play.play('audios/peepSound.wav');
        }
    });
  }
  bool _isFlashOn(String current) {
    return flashOn == current;
  }
  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
