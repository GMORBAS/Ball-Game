// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final IconData? icon;
  final function;
  final double? height;
  final double? width;
  final Color? color;

  const Boton({
    super.key,
    this.icon,
    this.function,
    this.height,
    this.width,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: color,
          height: height,
          width: width,
          child: Center(
            child: Icon(icon),
          ),
        ),
      ),
    );
  }
}
