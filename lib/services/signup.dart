import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> setupuser(
    String nom, String prenom, String tel, String type) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference user = firestore.collection('Users');

  User? cuser = FirebaseAuth.instance.currentUser;
  String uid = "";
  if (cuser != null) {
    uid = cuser.uid;
  }

  user.add({
    "uid": uid,
    "nom": nom,
    "prenom": prenom,
    "tel": tel,
    "type": type,
    "status": "Inactive"
  });
}
