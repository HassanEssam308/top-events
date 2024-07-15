import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ticket_widget/ticket_widget.dart';

class ticketspage extends StatefulWidget {
  const ticketspage({super.key});

  @override
  State<ticketspage> createState() => _ticketspageState();
}

class _ticketspageState extends State<ticketspage> {
  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: _firestore.collection('tickets').snapshots(),
                //stream: _firestore.collection('events').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(child: CircularProgressIndicator());
                  }

                  List<DocumentSnapshot> docs = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      String text = docs[index].get('qrcode');
                      String name = docs[index].get('name');

                      return Card(
                        child: ExpansionTile(
                          collapsedBackgroundColor: Colors.white,
                          backgroundColor: Colors.deepPurple,

                          title: Text(name), // Display event name as title
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TicketWidget(
                                color: Colors.white,
                                width: 350,
                                height: 500,
                                isCornerRounded: true,
                                padding: EdgeInsets.all(20),
                                child: Stack(
                                  children: [
                                   Column(
                                     crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      BarcodeWidget(
                                        data: text,
                                        barcode: Barcode.qrCode(),
                                        color: Colors.black,
                                        height: 150,
                                        width: 150,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        text,
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Add additional widgets as needed
                                    ],
                                  ),
                               ] ),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}