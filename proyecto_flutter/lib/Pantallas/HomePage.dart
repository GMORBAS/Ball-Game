// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:proyecto_flutter/Objetos/Boton.dart';
import 'package:proyecto_flutter/Pantallas/Juego.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      width: double.infinity,
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const DefaultTextStyle(
              style: TextStyle(
                fontFamily: 'PlanetBenson2',
                fontSize: 120,
                color: Colors.black,
              ),
              child: Text("BALL GAME"),
            ),
            Column(
              children: [
                Boton(
                  icon: Icons.play_arrow,
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Juego(),
                      ),
                    );
                  },
                  height: 70,
                  width: 70,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
