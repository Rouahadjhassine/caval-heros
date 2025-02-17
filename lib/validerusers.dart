import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'Suivie.dart';

class validerusers extends StatefulWidget {
  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<validerusers> {
  List<DataRow> _rows = [];
  String _type = "";
  String _displayname = "";

  @override
  initState() {
    super.initState();
    init();
    getType();
    _fetchData();
  }

  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void getType() async {
    String? uid = FirebaseAuth.instance.currentUser?.uid;
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
        .instance
        .collection('Users')
        .where('uid', isEqualTo: uid)
        .get();
    String type = "";
    String dn = "";
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = snapshot.docs;
    for (var doc in documents) {
      Map<String, dynamic> userData = doc.data();

      type = userData['type'];
      dn = userData['prenom'] + ' ' + userData['nom'];
    }
    setState(() {
      _type = type;
      _displayname = dn;
    });
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['nom'].toString())),
          DataCell(Text(data['prenom'].toString())),
          DataCell(Text(data['type'].toString())),
          DataCell(Text(data['status'].toString())),
          DataCell(
            ElevatedButton(
              onPressed: () {
                var collection = FirebaseFirestore.instance.collection('Users');
                collection
                    .doc(doc.id) // <-- Doc ID where data should be updated.
                    .update({"status": "Active"});
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown, // Set the desired color here
              ),
              child: Text('Activer'),
            ),
          ),
          DataCell(
            ElevatedButton(
              onPressed: () {
                var collection = FirebaseFirestore.instance.collection('Users');
                collection
                    .doc(doc.id) // <-- Doc ID where data should be updated.
                    .update({"status": "Inactive"});
                _fetchData();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.brown, // Set the desired color here
              ),
              child: Text('Desactiver'),
            ),
          )
        ],
      );
      rows.add(row);
    });

    setState(() {
      _rows = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    _type + ":" + _displayname,
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
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 243, 241, 241),
          border: Border.all(
            color: Colors.brown,
            width: 2.0,
          ),
        ),
        child: DataTable(
          columnSpacing: 2,
          columns: [
            DataColumn(label: Text('Nom')),
            DataColumn(label: Text('Prenom')),
            DataColumn(label: Text('Type')),
            DataColumn(label: Text('Status')),
            DataColumn(label: Text('Action')),
            DataColumn(label: Text('Action')),
          ],
          rows: _rows,
        ),
      )),
    );
  }
}
