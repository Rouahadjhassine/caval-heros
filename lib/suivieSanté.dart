import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Equipe3.dart';

class SuivieSante extends StatefulWidget {
  String docId = "";
  SuivieSante({required this.docId});
  @override
  _SuivieSanteState createState() => _SuivieSanteState();
}

class _SuivieSanteState extends State<SuivieSante> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _vaccinController = TextEditingController();
  final TextEditingController _visiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _vaccinController.dispose();
    _visiteController.dispose();

    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Traiter les données du formulaire ici
      String vaccin = _vaccinController.text;
      String visite = _visiteController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference ch =
          firestore.collection('/ch2/' + widget.docId + '/sante');
      Object dc = ch.add({
        "vaccin": vaccin,
        "visite": visite,
      });

      // Afficher les données dans la console (à des fins de démonstration)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Suivie Santé'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _vaccinController,
                  decoration: InputDecoration(
                    labelText: 'Vaccin',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les details du vaccin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _visiteController,
                  decoration: InputDecoration(
                    labelText: 'Visite',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les  details du visite';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xff7a5050),
                  ),
                  onPressed: () {
                    submitForm();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FirestoreDataTable(),
                        ));
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
          ),
        ));
  }
}
