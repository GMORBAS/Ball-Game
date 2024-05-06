// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:proyecto_flutter/Boton.dart';
import 'package:proyecto_flutter/Juego.dart';

import 'HowToPlay.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
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
              Container(
                margin: const EdgeInsets.all(25),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HowToPlay(),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                        color: Colors.white,
                        height: 55,
                        width: 100,
                        child: const Center(
                          child: DefaultTextStyle(
                              style: TextStyle(color: Colors.black),
                              child: Text("How to play")),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
