import 'package:get/get.dart';
import 'package:top_events/constants.dart';

class HomeController extends GetxController{
  Rx<int> selectedIndex =Rx(0);
  Rx<bool>  isAdmin=Rx(false);

  @override
  onReady(){
    super.onReady();
    isAdmin.value=(box.read("isAdmin"))??false;
  }

  void changeScreen(int index){
    selectedIndex.value=index ;
  }
  @override
  void onInit() {
// print("onInit*******HomeController******selectedIndex =${selectedIndex.value}");
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    selectedIndex.value=0;
    // print("onClose*******HomeController******selectedIndex =${selectedIndex.value}");
  }
}