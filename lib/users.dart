import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatScreen.dart';

class UserListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Liste des utilisateurs'),
        backgroundColor: Color(0xff7a5050),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> userData =
                  document.data() as Map<String, dynamic>;
              String type = userData['type'] ?? 'N/A';
              String nom = userData['nom'] ?? 'N/A';
              String prenom = userData['prenom'] ?? 'N/A';
              String ruid = userData['uid'] ?? 'N/A';
              String displayName = prenom + ' ' + nom;
              String currentDisplayName = "Moi";
              User? cuser = FirebaseAuth.instance.currentUser;

              String uid = "";
              String? sDisplayName = "";
              if (cuser != null) {
                uid = cuser.uid;
              }
              snapshot.data!.docs.forEach((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                String nom = data['nom'].toString();
                String prenom = data['prenom'].toString();
                String xuid = data['uid'].toString();
                if (uid == xuid) {
                  currentDisplayName = prenom + ' ' + nom;
                }
                print(currentDisplayName);
              });

              return ListTile(
                  title: Text(displayName),
                  subtitle: Text('Type: $type'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatScreen(
                          receiverUid: ruid,
                          senderUid: uid,
                          senderDisplayName: currentDisplayName,
                          recieverDisplayName: displayName,
                        ),
                      ),
                    );
                  });
            }).toList(),
          );
        },
      ),
    );
  }
}
