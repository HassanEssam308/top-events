import 'package:get/get.dart';

class HomeController extends GetxController{
  Rx<int> selectedIndex =Rx(0);

  void changeScreen(int index){
    selectedIndex.value=index ;
  }
}