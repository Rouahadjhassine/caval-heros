import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cheveaux/suivieNouriture.dart';

import 'Home.dart';
import 'suivieSabot.dart';
import 'suivieSanté.dart';
import 'users.dart';

class FirestoreDataTableSuivie extends StatefulWidget {
  String docId = "";

  FirestoreDataTableSuivie({required this.docId});
  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<FirestoreDataTableSuivie> {
  List<DataRow> _rowsStante = [];
  List<DataRow> _rowsSabot = [];
  List<DataRow> _rowsAlimentation = [];
  String _type = "";
  String _displayname = "";

  @override
  void initState() {
    super.initState();
    _fetchDataSante();
    getType();
    _fetchDataSabot();
    _fetchDataAlimentation();
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
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + widget.docId + '/sante')
        .get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
   DataRow row = DataRow(
  cells: [
    DataCell(
      Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Text(
          data['vaccin'].toString(),
          style: TextStyle(color: Colors.brown),
        ),
      ),
    ),
    DataCell(
      Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.brown,
        child: Text(
          data['visite'].toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
  ],
);

      rows.add(row);
    });

    setState(() {
      _rowsStante = rows;
    });
  }

  Future<void> _fetchDataSabot() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + widget.docId + '/sabot')
        .get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
   DataRow row = DataRow(
  cells: [
    DataCell(
      Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.brown,
        child: Text(
          data['PES'].toString(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
    DataCell(
      Container(
        padding: EdgeInsets.all(8.0),
        color: Colors.white,
        child: Text(data['visite'].toString()),
      ),
    ),
  ],
);

      rows.add(row);
    });

    setState(() {
      _rowsSabot = rows;
    });
  }

  Future<void> _fetchDataAlimentation() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('/ch2/' + widget.docId + '/nouriture')
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
              onTap: () async {
                if (_type == 'veterinaire') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SuivieNouriture(docId: widget.docId),
                      ));
                }
                if (_type == 'palfrenier') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SuivieNouriture(docId: widget.docId),
                      ));
                }
                if (_type == 'marechal ferrant') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuivieSabot(docId: widget.docId),
                      ));
                }
              },
              child: Icon(Icons.add),
            ),
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
            GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
              },
              child: Icon(Icons.chat_bubble_outline),
            )
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
                width: 0.0,
              ),
            ),
            child: AppBar(
              title: Row(
                children: [
                  SizedBox(
                    height: 20.0,
                    child: Image.asset(
                      'lib/img/logoo.png',
                      width: 120.0,
                      height: 90.0,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
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
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Santé',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.brown,
                    width: 2.0,
                  ),
                ),
                child: DataTable(
                  dataRowColor: MaterialStateColor.resolveWith((states) => Colors.brown),
                  columnSpacing: 10,
                  columns: [
                    DataColumn(label: Text('Vaccin')),
                    DataColumn(label: Text('Visite')),
                  ],
                  rows: _rowsStante,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Entretien de sabots',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 253, 252, 251),
                  border: Border.all(
                    color: Colors.brown,
                    width: 2.0,
                  ),
                ),
            child: DataTable(
  dataRowColor: MaterialStateColor.resolveWith((states) => Colors.brown),
  columnSpacing: 10,
  columns: [
    DataColumn(label: Text('Produit entretien de sabots')),
    DataColumn(label: Text('Visite')),
  ],
  rows: _rowsSabot,
),
),
Padding(
  padding: const EdgeInsets.all(8.0),
  child: Text(
    'Nouriture',
    style: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    ),
  ),
),
Container(
  padding: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 252, 249, 248),
    border: Border.all(
      color: Colors.brown,
      width: 2.0,
    ),
  ),
  child: DataTable(
    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.brown),
    columnSpacing: 10,
    columns: [
      DataColumn(label: Text('Foin')),
      DataColumn(label: Text('Bouchon')),
      DataColumn(label: Text('Vitamine')),
    ],
    rows: _rowsAlimentation,
  ),
),

              
            ],
          ),
        ),
      );
    }
  }

