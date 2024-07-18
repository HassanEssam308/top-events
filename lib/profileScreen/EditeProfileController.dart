import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Editeprofilecontroller extends GetxController {
  File? imageFile;
  String? downloadUrl;

  TextEditingController name = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController ID = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController pass = TextEditingController();
  final auth = FirebaseAuth.instance;
  final ImagePicker _picker = ImagePicker();
  var stute = true.obs;

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
          .child('profiles/${DateTime
          .now()
          .millisecondsSinceEpoch}.jpg');
      final uploadTask = storageRef.putFile(imageFile!);

      final snapshot = await uploadTask;
      downloadUrl = await snapshot.ref.getDownloadURL();
      storedata(downloadUrl!);
      update();
    } catch (e) {
      print(e);
    }
  }

  storedata(String image) async {
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
          'image': image,
          'phone': phone.text
        });
        update();
        print('Document added successfully');
      } on FirebaseException catch (e) {
        print('Error: $e');
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  curent() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }

  // Future<void> updateEmail(String newEmail) async {
  //   print("*************fun update email$newEmail");
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     await user!.updateEmail(newEmail);
  //     // Update successful
  //     print("Email updated successfully");
  //   } catch (e) {
  //     // An error occurred
  //     print("Failed to update email: $e");
  //   }
  // }
  //
  // Future<void> updatePassword(String newPassword) async {
  //   try {
  //     User? user = FirebaseAuth.instance.currentUser;
  //     await user!.updatePassword(newPassword);
  //     // Update successful
  //     print("Password updated successfully");
  //   } catch (e) {
  //     // An error occurred
  //     print("Failed to update password: $e");
  //   }
  // }


  Future<void> updateEmail(String newEmail, String password) async {
    print("*************fun update email: $newEmail");
    try {

      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        print("No user currently signed in.");
        return;
      }
      print("*************fun update email: tadrosu");
      // Update email
      await user.updateEmail(newEmail);
      await user.sendEmailVerification();
      update();

      print("Email updated successfully");
    } catch (e) {
      print("Failed to update email: $e");
    }
  }


}
