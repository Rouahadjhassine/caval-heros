import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/Login.dart';
import'package:flutter_cheveaux/RoundedIcon.dart';
import 'package:flutter_cheveaux/text_filed_container.dart';

class confirmer extends StatelessWidget {
  bool _isSecurePassword= true ;
   confirmer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _isSecurePassword,

        decoration:  InputDecoration(
            icon: Icon(
              Icons.lock,
              color: Colors.white
            ),
            hintText: "Confirmer mot de passe",
            hintStyle:  TextStyle(fontFamily: 'OpenSans', color:Colors.white),
         

            border: InputBorder.none),
      ),
    );
  }
}