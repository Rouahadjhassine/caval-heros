import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/AccountManagement.dart';
import 'package:flutter_cheveaux/Suivie.dart';
import 'package:flutter_cheveaux/prop.dart';
import 'package:flutter_cheveaux/svptest.dart';
import 'package:flutter_cheveaux/validerusers.dart';
import 'package:flutter_cheveaux/vetr2.dart';
import 'Equipe3.dart';
import 'Login.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cheveaux/Login.dart';
import 'admine.dart';
import 'firebase_options.dart';
import 'march1.dart';
import 'march2.dart';
import 'welcome.dart';
import 'Cavalier.dart';
import 'Home.dart';
import 'Signup2.dart';
import 'veter1.dart';
import 'palf1.dart';
import 'palf2.dart';

import 'Proprietaire.dart';
import 'Entrenaire.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';

void main() {
  init();
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

Future<void> init() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/home',
        routes: {
          '/adm': (context) => admine(),
          '/palf1': (context) => palf1(),
          '/palf2': (context) => palf2(),
          '/march1': (context) => Marechalferrant(),
          '/march2': (context) => march(),
          '/vitr2': (context) => Vetr2(),
          '/entre': (context) => Entrenaire(),
          '/pro': (context) => prop(),
          '/vet': (context) => Vetr(),
          '/cav': (context) => Cavalier(),
          '/chek': (context) => Welcome(),
          '/login': (context) => Login(),
          '/home': (context) => Home(),
          '/signup': (context) => Signup(),
          '/svp': (context) => svptest(),
          '/equi3': (context) => FirestoreDataTable(),
          '/valid': (context) => validerusers(),
          '/suiv': (context) => FirestoreDataTableSuivie(
                docId: '',
              ),
        });
  }
}
