import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Suivie.dart';
import 'firebase_options.dart';

class FirestoreDataTable extends StatefulWidget {
  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<FirestoreDataTable> {
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
        await FirebaseFirestore.instance.collection('ch2').get();

    List<DataRow> rows = [];
    snapshot.docs.forEach((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      DataRow row = DataRow(
        cells: [
          DataCell(Text(data['nom'].toString())),
          DataCell(Text(data['race'].toString())),
          DataCell(Text(data['robe'].toString())),
          DataCell(Text(data['date naissance'].toString())),
          DataCell(
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        FirestoreDataTableSuivie(docId: doc.id.toString()),
                  ),
                );
                // Button action
                print("");
              },
              child: Text('Suivi'),
            ),
          ),
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
    Widget dataTable = DataTable(
      columnSpacing: 10,
      horizontalMargin: 10,
      border: TableBorder.all(
        color: Colors.brown,
        style: BorderStyle.solid,
      ),
      columns: [
        DataColumn(label: Text('Nom')),
        DataColumn(label: Text('Race')),
        DataColumn(label: Text('Robe')),
        DataColumn(label: Text('Date naissance')),
        DataColumn(label: Text('Suivi')),
      ],
      rows: _rows,
    );

    Widget styledDataTable = Container(
      color: Colors.white,
      padding: EdgeInsets.all(2.0),
      child: dataTable,
    );

    Widget body = SingleChildScrollView(
      child: styledDataTable,
    );

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
                  height: 0.0,
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
      body: body,
    );
  }
}
