// import 'dart:io';
//
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
//
// class Profilecontroller extends GetxController{
//   final FirebaseStorage _stroge=FirebaseStorage.instanceFor(
//       bucket: "chatapp-c4843.appspot.com"
//   );
//   String? download;
//   File? imagefile;
//   void pickImage() async {
//     ImagePicker picker=ImagePicker();
//     XFile? image= await picker.pickImage(source: ImageSource.gallery);
//     imagefile=File(image!.path);
//     update();
// }
//    Future<void> uploadImage() async {
//     if (imagefile == null) return;
//
//     try {
//       final storageRef = FirebaseStorage.instance.ref().child('uploads/${DateTime.now().millisecondsSinceEpoch}.jpg');
//       await storageRef.putFile(imagefile!);
//
//       final downloadURL = await storageRef.getDownloadURL();
//       download = downloadURL;
//       update();
//
//     } catch (e) {
//       print(e);
//     }
//   }
// }
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileController extends GetxController {
  File? imageFile;
  String? downloadUrl;

  TextEditingController name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController ID = TextEditingController();
  TextEditingController phone = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  var stute=true.obs;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      update();
    }
  }

  Future<void> uploadImage() async {
    if (imageFile == null) return;

    try {
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('profiles/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile!);

      final snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      update();
    } catch (e) {
      print(e);
    }
  }

  storedata() async {


    if (Email.text.isEmpty ||
        name.text.isEmpty ||
        ID.text.isEmpty ||
        phone.text.isEmpty) {
      print("please enter data");
    } else {
      try {
        final User? user = auth.currentUser;
        final uid = user!.uid;
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'email': Email.text,
          'name': name.text,
          'personalId': ID.text,
          'phone': phone.text
        });

        print('Document added successfully');
      } on FirebaseException catch (e) {
        print('Error: $e');
      } catch (e) {
        print('Error: $e');
      }
    }
  }



}
