import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';
import 'package:usave/components/pages_header.dart';

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
  QRViewController controller;

  void _endScanning()
  {
    Navigator.pop(context);
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
          MainButton('Cancel', Colors.grey,280,_endScanning),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrText = scanData;
      });
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
