import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {Key? key, this.press, this.textColor = Colors.black45, required this.text})
      : super(key: key);
  final String text;
  final Function()? press;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: newElevatedButton(),
      ),
    );
  }

  Widget newElevatedButton() {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.white,fontSize: 17),
      ),
      onPressed: press,
      style: ElevatedButton.styleFrom(
          primary: Color(0xff7a5050),
          padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
          textStyle: TextStyle(
              letterSpacing: 2,
              color: textColor,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans'
          )
      ),
    );
  }


}