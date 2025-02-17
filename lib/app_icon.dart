import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  final IconData icon;
  final Color backgroundcolor;
  final Color iconColor;
  final double size;
  final double iconsize;

  const AppIcon({
    Key? key,
    required this.icon,
    this.backgroundcolor = const Color.fromARGB(220, 255, 255, 225),
    this.iconColor = const Color(0xFF756d54),
    this.size = 45,
    this.iconsize = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size / 3.2),
        color: backgroundcolor,
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconsize,
      ),
    );
  }
}