import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_cheveaux/suivieNouriture.dart';
import 'package:flutter_cheveaux/svptest.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'suivieSanté.dart';
import 'suivieproprietaire.dart';
import 'users.dart';

class prop extends StatefulWidget {
  // String docId = "";
  prop();
  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<prop> {
  List<DataRow> _rowsStante = [];
  List<DataRow> _rowsSabot = [];
  List<DataRow> _rowsAlimentation = [];
  String _type = "";
  String _displayname = "";
  final CollectionReference Collection =
      FirebaseFirestore.instance.collection('training');

  @override
  initState() {
    super.initState();
    init();

    getType();
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
                  MaterialPageRoute(builder: (context) => svptest()),
                );
              },
              child: Text('Suivie'),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListPage()),
                );
              },
              child: Icon(Icons.chat_bubble_outline),
            ),
            GestureDetector(
                onTap: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushNamed(context, '/home');
                },
                child: Text('Deconexion'))
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
                      _type + " : " + _displayname,
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
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Collection.where('cavalier', isEqualTo: _displayname)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print(snapshot.error);
                    return Text('Error: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<QueryDocumentSnapshot> messages = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text('Date' +
                            ' : ' +
                            messages[index]['date'] +
                            '    Heure : ' +
                            messages[index]['time']),
                        subtitle: Text(
                            'Cheval' + ' : ' + messages[index]['HorseName']),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
