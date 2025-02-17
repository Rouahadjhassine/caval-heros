import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Equipe3.dart';

class SuivieSabot extends StatefulWidget {
  String docId = "";
  SuivieSabot({required this.docId});
  @override
  SuivieSabotState createState() => SuivieSabotState();
}

class SuivieSabotState extends State<SuivieSabot> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _pesController = TextEditingController();
  final TextEditingController _visiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pesController.dispose();
    _visiteController.dispose();

    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Traiter les données du formulaire ici
      String pes = _pesController.text;
      String visite = _visiteController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference ch =
          firestore.collection('/ch2/' + widget.docId + '/sabot');
      Object dc = ch.add({"pes": pes, "visite": visite});

      // Afficher les données dans la console (à des fins de démonstration)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Suivie Nouriture'),
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _pesController,
                  decoration: InputDecoration(
                    labelText: 'Produit Entretien de sabots',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les details des produits';
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
                      return 'Veuillez entrer les  details du Visite';
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
