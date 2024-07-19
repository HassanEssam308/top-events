import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/profileScreen/profilecontroller.dart';

import '../constants.dart';
import 'EditeProfileScreen.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  //bool stuts=true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              height: 200,
              color: Colors.deepPurple,
            ),
            Container(
              child: GetBuilder<ProfileController>(
                init: ProfileController(),
                builder: (controller) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          StreamBuilder(
                              stream: _firestore
                                  .collection('users')
                                  .doc(curent())
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: CircularProgressIndicator());
                                }

                                if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }

                                if (!snapshot.data!.exists) {
                                  return Center(
                                      child: Text('Document does not exist.'));
                                }

                                var userDocument = snapshot.data!;
                                String name = userDocument.get('name') ?? 'No name';
                                String email =
                                    userDocument.get('email') ?? 'No event ID';
                                String personalId =
                                    userDocument.get('personalId') ?? 'No event ID';
                                String phone =
                                    userDocument.get('phone') ?? 'No event ID';
                                String image =
                                    userDocument.get('image') ?? '';
                                return Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    children: [

                                      CircleAvatar(
                                        radius: 70,
                                        backgroundImage:image.isNotEmpty? NetworkImage(image)
                                        :const AssetImage('image/prson2.png'),
                                      ),
                                      SizedBox(
                                        height: 50,
                                      ),
                                      TextField(
                                        controller: controller.name,
                                        readOnly: true,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                            hintText: '$name',
                                            hintStyle: TextStyle(color: Colors.black),
                                            prefixIcon: Icon(Icons.person),
                                            ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        controller: controller.Email,
                                        readOnly: true,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                            hintText: '$email',
                                            hintStyle: TextStyle(color: Colors.black),
                                            prefixIcon: Icon(Icons.email),
                                            ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        controller: controller.ID,
                                        readOnly: true,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            hintText: '$personalId',
                                            hintStyle: TextStyle(color: Colors.black),
                                            prefixIcon:
                                                Icon(Icons.credit_card_outlined),
                                            ),
                                      ),
                                      SizedBox(
                                        height: 30,
                                      ),
                                      TextField(
                                        controller: controller.phone,
                                        readOnly: true,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                            hintText: '$phone',
                                            hintStyle: TextStyle(color: Colors.black),
                                            prefixIcon: Icon(Icons.phone),
                                           ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                          SizedBox(height: 70),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                          style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple),
                                onPressed: () {
                                  Get.to(Editeprofilescreen());
                                },
                                child: Text("Edite data",style: TextStyle(color: Colors.white,fontSize: 16),),
                              ),
                              SizedBox(width: 20,),

                              ElevatedButton(
                              style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple),
                                onPressed: (){
                                FirebaseAuth.instance.signOut();
                                box.write('uid',null);

                                Get.offAllNamed('/loginScreen');
                              }, child: const Text('LogOut',style: TextStyle(color: Colors.white,fontSize: 16),),),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  curent() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }
}
