import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';

import 'controllerRegister.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
      width: double.infinity,
      decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, colors: [
        Colors.deepPurple.shade400,
        Colors.deepPurple.shade600,
      ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        SizedBox(
          height: 100,
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 40,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Text("Creat New Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                    padding: EdgeInsets.only(top: 40, right: 15, left: 15),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        GetBuilder<Controllerregister>(
                          init: Controllerregister(),
                          builder: (controller) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.name,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'User Name',
                                      hintText: 'Enter your User Name',
                                      hintStyle: TextStyle(color: Colors.grey),
                                      prefixIcon: Icon(Icons.person),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.Email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Enter your Email',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(Icons.email),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.pass,
                                    keyboardType: TextInputType.text,
                                    obscureText: controller.isscure.value,
                                    decoration: InputDecoration(
                                        labelText: 'Password',
                                        hintText: 'Enter your password',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(Icons.password),
                                        suffixIcon: IconButton(
                                          onPressed: controller.seenpassword,
                                          icon: controller.isscure.value
                                              ? Icon(Icons.visibility)
                                              : Icon(Icons.visibility_off),
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.ID,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: 'Personal ID',
                                        hintText: 'Enter your Personal ID',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(Icons.credit_card),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.phone,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                        labelText: 'Phone',
                                        hintText: 'Enter your phone',
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        prefixIcon: Icon(Icons.phone),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  Container(
                                    width: 300,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple),
                                        onPressed: () async {
                                          await controller.creatacount();
                                          await controller.storedata(context);
                                          if (controller.state) {
                                            Get.to(() => LoginScreen(),transition: Transition.zoom,duration: Duration(seconds: 10));
                                          }
                                        },
                                        child: Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17),
                                        )),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    width: 200,
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Text("Already have Account ?"),
                                          InkWell(
                                            onTap: () {
                                              Get.to(LoginScreen(),transition: Transition.fade,duration: Duration(seconds: 1));
                                            },
                                            child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.indigo,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      ]),
                    ))))
      ]),
    )));
  }
}
