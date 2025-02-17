import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Equipe3.dart';

class SuivieNouriture extends StatefulWidget {
  String docId = "";
  SuivieNouriture({required this.docId});
  @override
  SuivieNouritureState createState() => SuivieNouritureState();
}

class SuivieNouritureState extends State<SuivieNouriture> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _foinController = TextEditingController();
  final TextEditingController _bouchonController = TextEditingController();
  final TextEditingController _vitamineController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _foinController.dispose();
    _bouchonController.dispose();
    _vitamineController.dispose();

    super.dispose();
  }

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Traiter les données du formulaire ici
      String foin = _foinController.text;
      String bouchon = _bouchonController.text;
      String vitamine = _vitamineController.text;

      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      final CollectionReference ch =
          firestore.collection('/ch2/' + widget.docId + '/nouriture');
      Object dc =
          ch.add({"foin": foin, "bouchon": bouchon, "vitamine": vitamine});

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
                  controller: _foinController,
                  decoration: InputDecoration(
                    labelText: 'Foin',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les details du foin';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bouchonController,
                  decoration: InputDecoration(
                    labelText: 'Bouchon',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les  details du Bouchon';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _vitamineController,
                  decoration: InputDecoration(
                    labelText: 'Vitamine',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Veuillez entrer les  details du Vitamine';
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
