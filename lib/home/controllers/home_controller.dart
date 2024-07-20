import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:top_events/constants.dart';

class HomeController extends GetxController {
  Rx<int> selectedIndex = Rx(0);
  Rx<bool> isAdmin = Rx(false);
  final _auth=FirebaseAuth.instance;

  @override
  onReady() {
    isAdmin.value = (box.read("isAdmin")) ?? false;
    print(
        "onReady*******HomeController******selectedIndex =${selectedIndex.value}");
    super.onReady();
  }

  void changeScreen(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    if (kDebugMode) {
      print(
        "onInit*******HomeController******selectedIndex =${selectedIndex.value}");
    }
    super.onInit();
    // saveIsAdminUseInGetStorage();
  }

  @override
  void onClose() {
    selectedIndex.value = 0;
    if (kDebugMode) {
      print(
        "onClose*******HomeController******selectedIndex =${selectedIndex.value}");
    }
    super.onClose();

  }

  Future<void>saveIsAdminUseInGetStorage() async {
    try{
      await fireStoreInstance.collection('users')
          .doc(_auth.currentUser?.uid)
          .get()
          .then(( DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
        if (documentSnapshot.exists) {
          if (kDebugMode) {
            print('********Document data: ${documentSnapshot.data()}');
          }
          bool isAdmin=  documentSnapshot.data()?['isAdmin'];
          box.write('isAdmin',isAdmin);
        } else {
          if (kDebugMode) {
            print('*********Document does not exist on the database');
          }
          box.write('isAdmin',false);

        }
      }).catchError((err){
        if (kDebugMode) {
          print('saveIsAdminUseInGetStorage ********* Error =$err');
        }
      });

    }catch(error){
      if (kDebugMode) {
        print('saveIsAdminUseInGetStorage *********catch Error =$error');
      }
    }
  }

}