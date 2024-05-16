// ignore_for_file: file_names

import 'package:flutter/material.dart';

class ComoJugar extends StatelessWidget {
  const ComoJugar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const DefaultTextStyle(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    "El juego es simple, MUEVE la PLATAFORMA TOCANDO un"
                    " lugar de la PANTALLA"
                    " para hacer que la bola rebote"
                    " en ella.\n\nCon cada rebote recibes un PUNTO Y el"
                    " TIEMPO restante AUMENTARÁ, intenta CONSEGUIR el"
                    " máximo de PUNTOS posible ANTES DE QUE SE ACABE"
                    " EL TIEMPO.",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset(
                      "assets/images/plataforma_moviendose.png",
                      width: 300,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
