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
   bool isAdminValue = (box.read("isAdmin")) ?? false;
    if (kDebugMode) {
      print("onReady****HomeController***selectedIndex =${selectedIndex.value}");
      print("onReady***HomeController***isAdmin =${isAdmin}");
      print("onReady***HomeController***isAdminValue =${isAdminValue}");

    }
    super.onReady();
  }

  void changeScreen(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    saveIsAdminUseInGetStorage();
    changeScreen(0);
    if (kDebugMode) {
      print("onInit*****HomeController****selectedIndex =${selectedIndex.value}");
      print("onInit*******HomeController******isAdmin =${isAdmin}");

    }
    super.onInit();
  }

  @override
  void onClose() {
    changeScreen(0);
    if (kDebugMode) {
      print("onClose***HomeController***selectedIndex =${selectedIndex.value}");
      print("onClose****HomeController***isAdmin =${isAdmin}");
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
          bool isAdminState=  documentSnapshot.data()?['isAdmin'];
          isAdmin.value=isAdminState ;
          update();
          box.write('isAdmin',isAdminState);
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
        box.write('isAdmin',false);
      });

    }catch(error){
      if (kDebugMode) {
        print('saveIsAdminUseInGetStorage *********catch Error =$error');
      }
      box.write('isAdmin',false);
    }
  }

}