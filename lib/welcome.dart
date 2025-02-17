import 'package:flutter/material.dart';

import 'package:flutter_cheveaux/roundedButtom.dart';
class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Container(
                  height: 500,
                  width: 1000,
              ),
                Padding(
                  padding: const  EdgeInsets. only(top: 250.0),
                  child: Container(
                    width: 500, //double.infinity,
                    height: 250,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(111,78,55,0),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50),
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Bienvenue!",
                          style: TextStyle(
                              color: Color.fromARGB(255, 231, 229, 225),
                              fontFamily: 'OpenSans',
                              fontSize: 25,
                              fontWeight: FontWeight.w600),
                        ),
                        
                        const SizedBox(height: 30),

                        Form(
                          child: Column(
                            children: [
                              RoundedButton(text: 'Se connecter', press: () {
                                Navigator.pushNamed(context, '/login');
                              }),
                            RoundedButton(text: 'S\'inscrire',
                                  press: () {
                                Navigator.pushNamed(context, '/signup');
                              }),
                              const SizedBox(
                                height: 10,
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