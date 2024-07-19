import 'package:get/get.dart';
import 'package:top_events/constants.dart';

class AllEventsController extends GetxController{

  Rx<String>  viewState=Rx('accepted');
  Rx<bool>  isAdmin=Rx(false);

   @override
  onReady(){
     super.onReady();
     isAdmin.value=(box.read("isAdmin"))??false;
   }

  changState(String state){
    viewState.value=state;
    refresh();
  }
}