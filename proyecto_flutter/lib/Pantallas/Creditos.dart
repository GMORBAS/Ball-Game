// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Creditos extends StatelessWidget {
  const Creditos({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      height: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          DefaultTextStyle(
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
            child: Text(
              textAlign: TextAlign.center,
              "Creado por: Gabriel Moraes Bastos\n\nComo un proyecto para PMDM",
            ),
          ),
        ],
      ),
    );
  }
}
