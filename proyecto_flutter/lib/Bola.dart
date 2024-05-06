// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Bola extends StatelessWidget {
  final double posicionX;
  final double posicionY;
  const Bola({super.key, required this.posicionX, required this.posicionY});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(posicionX, posicionY),
      child: Container(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        width: 20,
        height: 20,
      ),
    );
  }
}
