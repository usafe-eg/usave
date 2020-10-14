import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:usave/utilities/constants.dart';
import 'package:usave/components/mainbutton.dart';

const flashOn = 'FLASH ON';
const flashOff = 'FLASH OFF';
const frontCamera = 'FRONT CAMERA';
const backCamera = 'BACK CAMERA';

class ScanStudentPage  extends StatefulWidget {

  @override
  _ScanStudentPageState createState() => _ScanStudentPageState();
}

class _ScanStudentPageState extends State<ScanStudentPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  var qrText = "";
  var flashState = flashOn;
  var cameraState = frontCamera;
  QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mainColor,
        title: Padding(padding:EdgeInsets.only(top: 30,left: 20),
            child: Text('Scan Student Data',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 20),)),
      ),
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
          MainButton('Cancel', Colors.grey),
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
