import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_events/LoginScrren/ControllerLogin.dart';
import 'package:top_events/RegisterScreen/RegisterScreen.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

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
          height: 120,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
              Text("Login Your Account",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        SizedBox(height: 20),
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                    padding: EdgeInsets.only(top: 10, right: 15, left: 15),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        GetBuilder<Controllerlogin>(
                          init: Controllerlogin(),
                          builder: (controller) {
                            return Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 80,
                                  ),
                                  TextField(
                                    controller: controller.Email,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      hintText: ('Enter Email'),
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
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
                                    height: 15,
                                  ),
                                  Container(
                                    width: 400,
                                    child: InkWell(
                                      onTap: () async {
                                        await controller.resetpassword();
                                      },
                                      child: Text(
                                        "Forget your password?",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 100,
                                  ),
                                  Container(
                                    width: 300,
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.deepPurple),
                                        onPressed: () async {
                                        await  controller.login(context);
                                          if (kDebugMode) {
                                            print("***controller.state.value==${controller.state.value} *******");
                                          }
                                          if (controller.state.value == true) {
                                            Get.offNamed('/home');
                                            controller.saveUserIdInGetStorage();
                                          }
                                        },
                                        child: Text(
                                          "Login",
                                          style: TextStyle(color: Colors.white),
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
                                          Text("Don't have account ?"),
                                          InkWell(
                                            onTap: () {
                                              Get.to(RegisterScreen(), transition: Transition.zoom);
                                            },
                                            child: Text(
                                              "Register",
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
