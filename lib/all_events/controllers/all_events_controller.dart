import 'package:get/get.dart';
import 'package:top_events/constants.dart';

class AllEventsController extends GetxController{

  Rx<String>  viewState=Rx('accepted');
  Rx<bool>  isAdmin=Rx(false);

   @override
  onInit(){
     isAdmin.value=(box.read("isAdmin"))??false;
     super.onInit();
   }

  changState(String state){
    viewState.value=state;
    refresh();
  }
}