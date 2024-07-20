import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/Home/controllers/home_controller.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';
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
            body: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(begin: Alignment.topCenter, colors: [
                  Colors.deepPurple.shade400,
                  Colors.deepPurple.shade600,
                ])),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 70),
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(60),
                                      topRight: Radius.circular(60))),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, right: 15, left: 15),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
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
                                                        builder: (context,
                                                            snapshot) {
                                                          if (!snapshot
                                                              .hasData) {
                                                            return Center(
                                                                child:
                                                                    CircularProgressIndicator());
                                                          }

                                                          if (snapshot
                                                              .hasError) {
                                                            return Center(
                                                                child: Text(
                                                                    'Error: ${snapshot.error}'));
                                                          }

                                                          if (!snapshot
                                                              .data!.exists) {
                                                            return Center(
                                                                child: Text(
                                                                    'Document does not exist.'));
                                                          }

                                                          var userDocument =
                                                              snapshot.data!;
                                                          String name =
                                                              userDocument.get(
                                                                      'name') ??
                                                                  'No name';
                                                          String email =
                                                              userDocument.get(
                                                                      'email') ??
                                                                  'No event ID';
                                                          String personalId =
                                                              userDocument.get(
                                                                      'personalId') ??
                                                                  'No event ID';
                                                          String phone =
                                                              userDocument.get(
                                                                      'phone') ??
                                                                  'No event ID';
                                                          String image =
                                                              userDocument.get(
                                                                      'image') ??
                                                                  'No event ID';
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    horizontal:
                                                                        20),
                                                            child: Column(
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 70,
                                                                  backgroundImage: image
                                                                          .isNotEmpty
                                                                      ? NetworkImage(
                                                                          image)
                                                                      : const AssetImage(
                                                                          'image/prson2.png'),
                                                                ),
                                                                SizedBox(
                                                                  height: 50,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      controller
                                                                          .name,
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .text,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        '$name',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .person),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      controller
                                                                          .Email,
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .emailAddress,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        '$email',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .email),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      controller
                                                                          .ID,
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .number,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        '$personalId',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .credit_card_outlined),
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  height: 30,
                                                                ),
                                                                TextField(
                                                                  controller:
                                                                      controller
                                                                          .phone,
                                                                  readOnly:
                                                                      true,
                                                                  keyboardType:
                                                                      TextInputType
                                                                          .phone,
                                                                  decoration:
                                                                      InputDecoration(
                                                                    hintText:
                                                                        '$phone',
                                                                    hintStyle: TextStyle(
                                                                        color: Colors
                                                                            .black),
                                                                    prefixIcon:
                                                                        Icon(Icons
                                                                            .phone),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          );
                                                        }),
                                                    SizedBox(height: 70),
                                                    Padding(
                                                      padding: const EdgeInsets.only(bottom: 18.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .deepPurple),
                                                            onPressed: () {
                                                              Get.to(
                                                                  Editeprofilescreen());
                                                            },
                                                            child: Text(
                                                              "Edite data",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .deepPurple),
                                                            onPressed: () {
                                                              box.write('uid', null);
                                                              box.write('isAdmin',false);
                                                              FirebaseAuth.instance.signOut();
                                                              Get.offAllNamed('/loginScreen');
                                                              Get.delete<HomeController>();
                                                            },
                                                            child: const Text(
                                                              'LogOut',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 16),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
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
                              )))
                    ]))));
  }

  curent() {
    final User? user = auth.currentUser;
    final uid = user!.uid;
    return uid;
  }
}
