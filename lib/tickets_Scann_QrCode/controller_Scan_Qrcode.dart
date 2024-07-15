import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';

class ScannerQrcodeController extends GetxController {
  var qrstr = "let's Scan it";

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
}
