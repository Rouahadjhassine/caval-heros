import 'package:flutter/material.dart';

class BigTextWidget extends StatelessWidget {
  Color? color;
  final String? text;
  double size;
  TextOverflow overFlow;
  FontWeight fontWeight;
  BigTextWidget(
      {Key? key,
        this.color = const Color(0xff332d2b),
        required this.text,
        this.size = 20,
        this.fontWeight = FontWeight.w800,
        this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overFlow,
      style: TextStyle(
          fontSize: size,
          color: color,
          fontFamily: 'Roboto',
          fontWeight: fontWeight),
    );
  }
}