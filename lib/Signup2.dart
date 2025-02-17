import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/RoundedIcon.dart';
import 'package:flutter_cheveaux/rounded_input_filed.dart';
import 'package:flutter_cheveaux/text_filed_container.dart';
import 'package:flutter_cheveaux/rounded_password_field.dart';

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './services/signup.dart';

class Signup extends StatefulWidget {
  @override
  SignupState createState() => SignupState();
  Signup({Key? key}) : super(key: key);
}

class SignupState extends State<Signup> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nomController = TextEditingController();
  final prenomController = TextEditingController();
  final telCntroller = TextEditingController();
  final typeController = TextEditingController();
  List<String> dropdownItems = [
    'proprietaire',
    'cavalier',
    'marechal ferrant',
    'veterinaire',
    'palfrenier',
    'entraineur'
  ];
  String selectedValue = "proprietaire";

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight * 1.5),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.brown,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(320.0),
                bottomRight: Radius.circular(320.0),
                topLeft: Radius.circular(320.0),
                topRight: Radius.circular(320.0),
              ),
              border: Border.all(
                color: Color.fromARGB(255, 252, 246, 244),
                width: 4.0,
              ),
            ),
            child: AppBar(
              title: Row(
                children: [
                  SizedBox(
                    height: 40.0,
                    child: Image.asset(
                      'lib/img/logoo.png',
                      width: 120.0,
                      height: 90.0,
                    ),
                  ),
                  SizedBox(
                    height: 40.0,
                    child: Text(
                      'Bien Venu',
                      style: TextStyle(
                        color: Color.fromARGB(255, 252, 249, 248),
                        fontSize: 20,
                        fontFamily: 'serif',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 0.0,
              backgroundColor: Color.fromARGB(0, 235, 244, 245),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 300,
                  width: 700,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('.idea/img/4.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 220.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white54,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Inscription ",
                          style: TextStyle(
                              color: Colors.black45,
                              fontFamily: 'OpenSans',
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                  controller: nomController,
                                  hintText: "Nom",
                                  icon: Icons.person),
                              RoundedInputField(
                                  controller: prenomController,
                                  hintText: "Prénom",
                                  icon: Icons.person_2),
                              RoundedInputField(
                                  controller: emailController,
                                  hintText: "Email",
                                  icon: Icons.email),
                              RoundedPasswordField(controller: passController),
                              RoundedInputField(
                                  controller: telCntroller,
                                  hintText: "Telephone",
                                  icon: Icons.phone),
                              DropdownButton<String>(
                                value: selectedValue,
                                items: dropdownItems.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedValue = newValue!;
                                  });
                                },
                              ),
                              TextButton(
                                onPressed: () async {
                                  await Firebase.initializeApp(
                                    options:
                                        DefaultFirebaseOptions.currentPlatform,
                                  );
                                  try {
                                    UserCredential userCredential =
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                                email: emailController.text,
                                                password: passController.text);

                                    setupuser(
                                        nomController.text,
                                        prenomController.text,
                                        telCntroller.text,
                                        selectedValue);

                                    Navigator.pushNamed(context, '/home');
                                  } on FirebaseAuthException catch (e) {
                                    //null means unsuccessfull authentication
                                    // ignore: use_build_context_synchronously
                                    String msg = "";
                                    if (e.code == 'weak-password') {
                                      msg = 'Le mot de passe est tres faible';
                                    } else if (e.code ==
                                        'email-already-in-use') {
                                      msg = 'Ce mail existe deja';
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(e.code),
                                          );
                                        });
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text(
                                  'S\'inscrire',
                                  style: TextStyle(
                                    fontSize: 19,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
