import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'users.dart';

class Entrenaire extends StatefulWidget {
  Entrenaire({super.key});
  @override
  _FirestoreDataTableState createState() => _FirestoreDataTableState();
}

class _FirestoreDataTableState extends State<Entrenaire> {
  final CollectionReference Collection =
      FirebaseFirestore.instance.collection('riding');
  String _displayname = "";
  String _type = "";
  @override
  Future<void> initState() async {
    super.initState();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    getType();
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
        bottomNavigationBar:
            CurvedNavigationBar(backgroundColor: Color(0xff7a5050), items: [
          GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UserListPage()),
                );
              },
              child: Icon(Icons.chat_bubble_outline)),
          GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, '/home');
              },
              child: Text('Déconexion')),
        ]),
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
              title: Row(children: [
                SizedBox(
                  height: 40.0,
                  child: Image.asset(
                    'lib/img/logoo.png',
                    width: 150.0,
                    height: 100.0,
                  ),
                ),
                SizedBox(
                  height: 40.0,
                  child: Text(
                    _type + " : " + _displayname,
                    style: TextStyle(
                      color: Color.fromARGB(255, 252, 249, 248),
                      fontSize: 25,
                      fontFamily: 'serif',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ]),
              elevation: 0.0,
              backgroundColor: Color.fromARGB(0, 235, 244, 245),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: Collection.where('entraineur', isEqualTo: _displayname)
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
                        subtitle:
                            Text('Groupe' + ' : ' + messages[index]['group']),
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
