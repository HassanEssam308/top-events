import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../all_events/controllers/all_events_controller.dart';

class CustomOutlineButton extends StatelessWidget {
final String text;
final AllEventsController allEventsController;
   const CustomOutlineButton({ super.key ,
    required this.text,required this.allEventsController});


  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=> Padding(
        padding: const EdgeInsets.all(3.0),
        child: Opacity(
            opacity: (allEventsController.viewState.value == text)? 1:.3,
            child: OutlinedButton(

              onPressed: (){
              allEventsController.changState(text);
            },
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.zero,
                backgroundColor:(allEventsController.viewState.value == text) ? Colors.black  : Colors.grey ,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
                side: BorderSide(
                    color:  (allEventsController.viewState.value == text) ? Colors.green  : Colors.black),
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: (allEventsController.viewState.value == text) ? Colors.green  : Colors.black,
                ),
              ),

            ),
          ),
      ),
    );
    }
  }

