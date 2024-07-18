import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScannerQrcodeController extends GetxController {
  var qrstr = "";
  String oneid="";
  String twoid="";

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        qrstr = value;
        update();
      });
    } catch (e) {
      qrstr = 'unable to read this';
      update();
    }
  }
  splitcode(){
    String inputString = qrstr;
    List<String> splitString = inputString.split('/');
    oneid=splitString[0];
    twoid=splitString[1];
    print("****************$oneid");
    print("****************$twoid");
    update();

  }


}
