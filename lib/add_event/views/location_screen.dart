import 'package:flutter/material.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: Column(
          children: [
            const Text('Column'),
            Text('Column'),
            Text('Column'),
            Text('Column'),
            Text('Column'),
      
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: (){
                Navigator.pop(context);
              },
                  child: const Text('Save')),
            )
          ],
        ),
      ),
    );
  }
}
