import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
      ),
      body: Column(
        children: [
          Container(
            alignment: AlignmentDirectional.centerEnd,
            padding: EdgeInsets.all(10),
            child: MaterialButton(
              color:  Colors.green,
              elevation: 10,
              onPressed: () {
                Get.toNamed('/addEvent');
              },
              child: const Text("Add Event"),
            ),
          ),
          Expanded(
              child: drawerCardOfEvents())
        ],
      ),
    ));
  }

  Widget drawerCardOfEvents(){
    final Stream<QuerySnapshot>  eventsStream = dbFireStore.collection('events')
        .orderBy('date',descending: true)
        .snapshots();

    return   StreamBuilder<QuerySnapshot>(
      stream: eventsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return  const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return  const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return   Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child:Column(
                  children: [
                    Text(data['title']),
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //     children: [
                    //       Image.network('src')
                    //     ],
                    //   ),
                    // ),
                    Text(data['priceOfTicket'].toString()),
                    Text(data['date'].toString()),
                  ],
                ) ,
              ),
            );
          }).toList(),
        );
      },
    );
  }
 Widget drawerFloatingActionButton(){
  return   FloatingActionButton(
      onPressed: (){},
      tooltip: 'Add Event',
      child: const Icon(Icons.add),
    );
  }

}
