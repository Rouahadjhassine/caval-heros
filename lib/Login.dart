import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/RoundedIcon.dart';
import 'package:flutter_cheveaux/rounded_input_filed.dart';
import 'package:flutter_cheveaux/rounded_password_field.dart';
import 'Cavalier.dart';
import 'Entrenaire.dart';
import 'Equipe3.dart';
import 'Home.dart';
import 'RoundedIcon.dart';
import 'package:flutter_cheveaux/roundedButtom.dart';
import 'package:flutter_cheveaux/RoundedIcon.dart';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';
import 'package:firebase_core/firebase_core.dart';
import 'admine.dart';
import 'firebase_options.dart';
import 'prop.dart';

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passController = TextEditingController();

  String _email = "";
  String _password = "";
  final String _displayName = "";
  bool _loading = false;
  bool _autoValidate = false;
  String errorMsg = "";
  @override
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
                      'Bienvenue',
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
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 200,
                  width: 600,
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    //shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/img/logoo.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 320.0),
                  child: Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        iconButton(context),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          child: Column(
                            children: [
                              RoundedInputField(
                                  controller: emailController,
                                  hintText: "Email",
                                  icon: Icons.email),
                              RoundedPasswordField(controller: passController),
                              TextButton(
                                onPressed: () async {
                                  await Firebase.initializeApp(
                                    options:
                                        DefaultFirebaseOptions.currentPlatform,
                                  );
                                  try {
                                    String type = "";
                                    String status = "";
                                    final credential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passController.text);
                                    String? uid =
                                        FirebaseAuth.instance.currentUser?.uid;
                                    QuerySnapshot<Map<String, dynamic>>
                                        snapshot = await FirebaseFirestore
                                            .instance
                                            .collection('Users')
                                            .where('uid', isEqualTo: uid)
                                            .get();
                                    List<
                                            QueryDocumentSnapshot<
                                                Map<String, dynamic>>>
                                        documents = snapshot.docs;
                                    for (var doc in documents) {
                                      Map<String, dynamic> userData =
                                          doc.data();

                                      type = userData['type'];
                                      status = userData['status'];
                                    }
                                    print('status:' + status);
                                    if (status == 'Inactive') {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content:
                                                  Text('Utilisateur inactive'),
                                            );
                                          });
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Home()),
                                      );
                                    } else if (type == 'proprietaire') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => prop()),
                                      );
                                    } else if (type == 'admin') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => admine()),
                                      );
                                    } else if (type == 'cavalier') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Cavalier()),
                                      );
                                    } else if (type == 'entraineur') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Entrenaire()),
                                      );
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                FirestoreDataTable()),
                                      );
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    String msg = "";
                                    if (e.code == 'user-not-found') {
                                      msg = 'Mail introuvable';
                                    } else if (e.code == 'wrong-password') {
                                      msg = 'Mot de passe incorrect';
                                    }
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: Text(e.code),
                                          );
                                        });
                                  }
                                },
                                child: Text(
                                  'Se connecter',
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
                              const SizedBox(
                                height: 20,
                              )
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

iconButton(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: const [
      // RoundedIcon(imageUrl: "img/img102.jpg"),
      SizedBox(
        width: 20,
      ),
      //RoundedIcon(Icon(icon.lock)),
      SizedBox(
        width: 20,
      ),
    ],
  );
}
