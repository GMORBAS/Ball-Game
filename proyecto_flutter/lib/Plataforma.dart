// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';

class Plataforma extends StatelessWidget {
  double posicionX;
  Plataforma({
    super.key,
    required this.posicionX,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(posicionX, 1),
      child: Container(
        color: Colors.brown,
        height: 10,
        width: 150,
      ),
    );
  }
}
