import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'EditeProfileController.dart';

class EditeProfileScreen extends StatelessWidget {
  EditeProfileScreen({super.key});

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
                        child: SingleChildScrollView(
                          child: Container(
                            child: GetBuilder<Editeprofilecontroller>(
                              init: Editeprofilecontroller(),
                              builder: (controller) {
                                return Center(
                                    child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    StreamBuilder(
                                        stream: _firestore
                                            .collection('users')
                                            .doc(controller.curent())
                                            .snapshots(),
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          }

                                          if (snapshot.hasError) {
                                            return Center(
                                                child: Text(
                                                    'Error: ${snapshot.error}'));
                                          }

                                          if (!snapshot.data!.exists) {
                                            return Center(
                                                child: Text(
                                                    'Document does not exist.'));
                                          }

                                          var userDocument = snapshot.data!;
                                          // String name =
                                          //     userDocument.get('name') ??
                                          //         'No name';
                                          // String email =
                                          //     userDocument.get('email') ??
                                          //         'No event ID';
                                          // String personalId =
                                          //     userDocument.get('personalId') ??
                                          //         'No event ID';
                                          // String phone =
                                          //     userDocument.get('phone') ??
                                          //         'No event ID';
                                          // String image =
                                          //     userDocument.get('image') ??
                                          //          'No event ID';
                                          controller.name.text = userDocument.get('name') ??
                                                  'No name';
                                          controller.Email.text = userDocument.get('email') ??
                                                  'No email';
                                          controller.ID.text = userDocument.get('personalId') ??
                                                  'No personal ID';
                                          controller.phone.text= userDocument.get('phone') ??
                                                  'No phone';
                                          String image =
                                              userDocument.get('image') ??
                                                  'No image';
                                          return Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 10),
                                                Stack(
                                                  alignment:
                                                      AlignmentDirectional
                                                          .bottomEnd,
                                                  children: [
                                                    CircleAvatar(
                                                      radius: 70,
                                                      backgroundImage: controller.imageFile !=
                                                          null
                                                          ? FileImage(controller.imageFile!)
                                                      as ImageProvider
                                                          :image.isNotEmpty? NetworkImage(image)
                                                          :const AssetImage('image/prson2.png'),
                                                    ),
                                                    InkWell(
                                                      onTap: () {
                                                        controller.pickImage();
                                                        controller
                                                            .uploadImage();
                                                        controller
                                                            .storeData(context);
                                                      },
                                                      child: Container(
                                                        height: 35,
                                                        width: 35,
                                                        decoration:
                                                            BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      100),
                                                          color:
                                                              Colors.deepPurple,
                                                        ),
                                                        child: Icon(
                                                          Icons.camera_alt,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 50,
                                                ),
                                                TextField(
                                                  controller: controller.name,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  decoration: InputDecoration(
                                                      hintText:'name',
                                                      labelText: 'Enter name' ,
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      prefixIcon:
                                                          Icon(Icons.person),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                TextField(
                                                  controller: controller.Email,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                      hintText: 'Email',
                                                      labelText: ' Enter email',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      prefixIcon:
                                                          Icon(Icons.email),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                TextField(
                                                  controller: controller.pass,
                                                  keyboardType: TextInputType
                                                      .visiblePassword,
                                                  decoration: InputDecoration(
                                                      hintText: '*******',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      prefixIcon:
                                                          Icon(Icons.password),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                TextField(
                                                  controller: controller.ID,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText: 'personalId',
                                                      labelText: ' Enter personalId',
                                                      prefixIcon: Icon(Icons
                                                          .credit_card_outlined),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                                SizedBox(
                                                  height: 30,
                                                ),
                                                TextField(
                                                  controller: controller.phone,
                                                  keyboardType:
                                                      TextInputType.number,
                                                  decoration: InputDecoration(
                                                      hintText: 'phone',
                                                      labelText: ' Enter phone',
                                                      hintStyle: TextStyle(
                                                          color: Colors.grey),
                                                      prefixIcon:
                                                          Icon(Icons.phone),
                                                      border:
                                                          OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10))),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                    SizedBox(height: 20),
                                    Center(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple),
                                        onPressed: () async {
                                          //controller.uploadImage();
                                          //await controller.updateEmail(controller.Email.text,controller.pass.text);
                                          // await controller.updatePassword(controller.pass.text);
                                          controller.storeData(context);
                                         // if (controller.stat) {
                                            Get.back();
                                          //}
                                        },
                                        child: const Text(
                                          'Save data',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ));
                              },
                            ),
                          ),
                        ),
                      ))
                    ]))));
  }
}
