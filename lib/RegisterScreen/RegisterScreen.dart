import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/LoginScrren/LoginScreen.dart';

import 'controllerRegister.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});


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
        const SizedBox(
          height: 100,
        ),
        const Padding(
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
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                    padding: const EdgeInsets.only(top: 40, right: 15, left: 15),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        GetBuilder<Controllerregister>(
                          init: Controllerregister(),
                          builder: (controller) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.name,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      labelText: 'User Name',
                                      hintText: 'Enter your User Name',
                                      hintStyle: const TextStyle(color: Colors.grey),
                                      prefixIcon: const Icon(Icons.person),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.Email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        labelText: 'Email',
                                        hintText: 'Enter your Email',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(Icons.email),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
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
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(Icons.password),
                                        suffixIcon: IconButton(
                                          onPressed: controller.seenpassword,
                                          icon: controller.isscure.value
                                              ? const Icon(Icons.visibility)
                                              : const Icon(Icons.visibility_off),
                                          color: Colors.grey,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.ID,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Personal ID',
                                        hintText: 'Enter your Personal ID',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(Icons.credit_card),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  TextField(
                                    controller: controller.phone,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Phone',
                                        hintText: 'Enter your phone',
                                        hintStyle:
                                            const TextStyle(color: Colors.grey),
                                        prefixIcon: const Icon(Icons.phone),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  SizedBox(
                                    width: 300,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple),
                                        onPressed: () async {
                                          await controller.creatacount();
                                          await controller.storedata(context);
                                          if (controller.state) {
                                            Get.to(() => LoginScreen(),transition: Transition.zoom,duration: Duration(seconds: 1));
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
                                          const Text("Already have Account ?"),
                                          InkWell(
                                            onTap: () {
                                              Get.to(LoginScreen(),transition: Transition.fade,duration: Duration(seconds: 1));
                                            },
                                            child: const Text(
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
