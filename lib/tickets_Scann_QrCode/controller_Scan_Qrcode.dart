import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScannerQrcodeController extends GetxController {
  var qrstr = "";
  String personalid="";
  String eventid="";

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        qrstr = value;
        if(value!='-1'){
          splitcode(value);
        update();
        }
      });
    } catch (e) {
      qrstr = 'unable to read this';
      update();
    }
  }
  splitcode(String qrcodeString ){
    print("**splitcode**************qrcodeString=$qrcodeString");
    String inputString = qrcodeString;
    List<String> splitString = inputString.split('/');
    personalid=splitString[0];
    eventid=splitString[1];
    print("****************$personalid");
    print("****************$eventid");
    update();

  }


}
