import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:top_events/constants.dart';

class HomeController extends GetxController {
  Rx<int> selectedIndex = Rx(0);
  Rx<bool> isAdmin = Rx((box.read("isAdmin")) ?? false);


  void changeScreen(int index) {
    selectedIndex.value = index;
    update();
  }

  @override
  void onInit() {
    isAdmin.value= (box.read("isAdmin")) ?? false;
    changeScreen(0);
    if (kDebugMode) {
      print("onInit*****HomeController****selectedIndex =${selectedIndex.value}");
      print("onInit*******HomeController******isAdmin =${isAdmin.value}");

    }
    super.onInit();
  }

  @override
  void onClose() {
    changeScreen(0);
    if (kDebugMode) {
      print("onClose***HomeController***selectedIndex =${selectedIndex.value}");
      print("onClose****HomeController***isAdmin =${isAdmin.value}");
    }
    super.onClose();

  }

}