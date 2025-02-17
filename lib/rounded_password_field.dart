import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/Login.dart';
import 'package:flutter_cheveaux/RoundedIcon.dart';
import 'package:flutter_cheveaux/text_filed_container.dart';

class RoundedPasswordField extends StatelessWidget {
  TextEditingController controller;
  bool _isSecurePassword = true;
  RoundedPasswordField({
    Key? key,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        obscureText: _isSecurePassword,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.white),
            hintText: "Password",
            hintStyle: TextStyle(fontFamily: 'OpenSans', color: Colors.white),
            suffixIcon: IconButton(
              onPressed: () {
                _isSecurePassword = !_isSecurePassword;
              },
              icon: _isSecurePassword
                  ? Icon(
                      Icons.visibility_off,
                    )
                  : Icon(
                      Icons.visibility,
                    ),
            ),
            border: InputBorder.none),
      ),
    );
  }
}
