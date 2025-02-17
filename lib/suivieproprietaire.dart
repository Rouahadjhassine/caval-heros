import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cheveaux/suivieNouriture.dart';

import 'suivieSabot.dart';
import 'users.dart';

class suivieprop extends StatefulWidget {
  // String docId = "";

  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<suivieprop> {
  List<DataRow> _rowsStante = [];
  List<DataRow> _rowsSabot = [];
  List<DataRow> _rowsAlimentation = [];
  String _type = "";
  String _displayname = "";
  final CollectionReference Collection =
      FirebaseFirestore.instance.collection('training');

  @override
  void initState() {
    super.initState();
    getType();
    _fetchDataSante();

    //_fetchDataSabot();
    //_fetchDataAlimentation();
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

  Future<void> _fetchDataSante() async {
    String docId = "";
    print('type:' + _type);

    QuerySnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore
        .instance
        .collection('ch2')
        .where('proprietaire', isEqualTo: _displayname)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        snapshot1.docs;
    for (var doc in documents) {
      Map<String, dynamic> userData = doc.data();
      docId = doc.id;
    }

    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + docId + '/sante')
        .get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['vaccin'].toString())),
          DataCell(Text(data['visite'].toString())),
        ],
      );
      rows.add(row);
    });

    setState(() {
      _rowsStante = rows;
    });
  }

  Future<void> _fetchDataSabot() async {
    String docId = "";
    QuerySnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore
        .instance
        .collection('ch2')
        .where('proprietaire', isEqualTo: _displayname)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        snapshot1.docs;
    for (var doc in documents) {
      Map<String, dynamic> userData = doc.data();
      docId = doc.id;
    }
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + docId + '/sabot')
        .get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['PES'].toString())),
          DataCell(Text(data['visite'].toString())),
        ],
      );
      rows.add(row);
    });

    setState(() {
      _rowsSabot = rows;
    });
  }

  Future<void> _fetchDataAlimentation() async {
    String docId = "";
    QuerySnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore
        .instance
        .collection('ch2')
        .where('proprietaire', isEqualTo: _displayname)
        .get();
    List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
        snapshot1.docs;
    for (var doc in documents) {
      Map<String, dynamic> userData = doc.data();
      docId = doc.id;
    }
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + docId + '/nouriture')
        .get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['foin'].toString())),
          DataCell(Text(data['bouchon'].toString())),
          DataCell(Text(data['vitamine'].toString()))
        ],
      );
      rows.add(row);
    });

    setState(() {
      _rowsAlimentation = rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor: Color(0xff7a5050),
          items: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserListPage(),
                    ));
              },
              child: Icon(Icons.chat_bubble_outline),
            ),
          ],
        ),
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
            child: Padding(
                padding: const EdgeInsets.all(400.0),
                child: Column(children: [
                  Text(
                    'Santé',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Container(
                      child: Column(children: [
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Vaccin')),
                        DataColumn(label: Text('Visite')),
                      ],
                      rows: _rowsStante,
                    ),
                    Text(
                      'Entretien de sabots',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Produit entretien de sabots')),
                        DataColumn(label: Text('Visite'))
                      ],
                      rows: _rowsSabot,
                    ),
                    Text(
                      'Nouriture',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(label: Text('Foin')),
                        DataColumn(label: Text('Bouchon')),
                        DataColumn(label: Text('Vitamine')),
                      ],
                      rows: _rowsAlimentation,
                    )
                  ])),
                ]))));
  }
}
