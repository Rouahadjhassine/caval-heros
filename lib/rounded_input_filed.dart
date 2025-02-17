import 'package:flutter/material.dart';
import 'package:flutter_cheveaux/Login.dart';
import 'package:flutter_cheveaux/text_filed_container.dart';

class RoundedInputField extends StatelessWidget {
  RoundedInputField(
      {Key? key,
      required this.controller,
      this.hintText,
      this.icon = Icons.person})
      : super(key: key);
  final String? hintText;
  final IconData icon;
  TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            icon: Icon(
              icon,
              color: Colors.white,
            ),
            hintText: hintText,
            hintStyle:
                const TextStyle(fontFamily: 'OpenSans', color: Colors.white),
            border: InputBorder.none),
      ),
    );
  }
}
