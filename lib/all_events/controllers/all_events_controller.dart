import 'package:get/get.dart';

class AllEventsController extends GetxController{

  Rx<String>  viewState=Rx('accepted');

  changState(String state){
    viewState.value=state;
    refresh();
  }
}