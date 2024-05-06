// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:proyecto_flutter/Bola.dart';
import 'package:proyecto_flutter/Boton.dart';
import 'package:proyecto_flutter/Plataforma.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Juego extends StatefulWidget {
  const Juego({super.key});

  @override
  // ignore: no_logic_in_create_state
  State<Juego> createState() {
    var state = JuegoState();
    state.jugar();
    return state;
  }
}

enum DIRECCION { derecha, izquierda }

class JuegoState extends State<Juego> {
  /* VARIABLES PLATAFORMA */
  double plataformaPosX = 0;
  final double velocidadMovimiento = 0.33333333333333;

  void moverPlataforma1() {
    plataformaPosX = -1;
  }

  void moverPlataforma2() {
    plataformaPosX = -0.5;
  }

  void moverPlataforma3() {
    plataformaPosX = 0;
  }

  void moverPlataforma4() {
    plataformaPosX = 0.5;
  }

  void moverPlataforma5() {
    plataformaPosX = 1;
  }

  /* VARIABLES BOLA */
  double bolaPosX = 1;
  double bolaPosY = -1;
  double bolaVelocidadX = Random.secure().nextDouble() * (0.02 - 0.003) + 0.02;
  final double bolaVelocidadY = 70;
  var direccionBola;

  /* VARIABLES JUEGO */
  int puntos = 0;
  int segundos = 5;
  int mejorPuntuacion = 0;

  void jugar() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('mejorpuntuacion')) {
      prefs.setInt('mejorpuntuacion', 0);
    }
    mejorPuntuacion = prefs.getInt('mejorpuntuacion')!;
    puntos = 0;
    segundos = 5;
    bolaPosY = 0;
    bool cambioDireccion = Random.secure().nextBool();
    if (cambioDireccion) {
      direccionBola = DIRECCION.derecha;
    } else {
      direccionBola = DIRECCION.izquierda;
    }
    plataformaPosX = 0;
    /* VARIABLES DE ECUACIÓN DE REBOTE */
    ///La fuerza de atracción al suelo de la bola
    double gravedad = Random.secure().nextDouble() * (15 - 5) + 5;

    ///El momento inicial del salto
    double tiempo = 0;

    ///Altura inicial del salto de la bola
    double altura = 0;

    //Cada 10 milisegundos
    Timer.periodic(const Duration(milliseconds: 12), (timer) {
      ///Una ecuación que define el rebote de objetos en la vida real (sin la friccón del aire)
      altura = -gravedad * tiempo * tiempo + bolaVelocidadY * tiempo;

      //Si la bola fuese a ir bajo el suelo o lo toca
      if (altura <= 0) {
        //Resetea el salto
        tiempo = 0;
      }

      //Cambia la altura de la bola
      setState(() {
        bolaPosY = alturaAPosicion(altura);
      });

      //Si la posición a la que se moverá la bola fuese a superar el borde izquierdo de la pantalla
      if (bolaPosX - bolaVelocidadX < -1) {
        //Cambia su dirección a la derecha
        direccionBola = DIRECCION.derecha;
        //Y si la posición a la que se moverá la bola fuese a superar el borde derecho de la pantalla
      } else if (bolaPosX + bolaVelocidadX > 1) {
        //Cambia su dirección a la izquierda
        direccionBola = DIRECCION.izquierda;
      }

      //Si la dirección de la bola es derecha
      if (direccionBola == DIRECCION.derecha) {
        //Que su posición en el axis X aumente
        setState(() {
          bolaPosX += bolaVelocidadX;
        });
        //Y si la dirección de la bola es izquierda
      } else {
        //Que su posición en el axis X diminuya
        setState(() {
          bolaPosX -= bolaVelocidadX;
        });
      }

      //Cada vez que la bola entre en el area de la canasta
      if ((bolaPosX - plataformaPosX).abs() < 0.2 && bolaPosY > 1) {
        //Añade tiempo al contador
        segundos += 5;
        //Aumenta la cantidad de puntos ganados
        puntos++;
        //Y randomiza los atributos del movimiento de la bola
        gravedad = Random.secure().nextDouble() * (15 - 5) + 5;
        bolaVelocidadX = Random.secure().nextDouble() * (0.02 - 0.003) + 0.02;
      }

      //Si se acaba el tiempo
      if (segundos == 0) {
        //Detén el juego
        timer.cancel();
      }

      //Aumenta el tiempo (cambiar el valor del cambio hará que la bola avance respectivamente en el tiempo)
      tiempo += 0.1;
    });

    ///Contador de segundos
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      segundos--;
      //Si el contador llega a cero
      if (segundos == 0) {
        if (puntos > mejorPuntuacion) {
          mejorPuntuacion = puntos;
          await prefs.setInt('mejorpuntuacion', puntos);
        }
        //Detén el juego
        timer.cancel();
        //Y muestra un pop-up de game over
        showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (_) => AlertDialog(
                  content: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ///texto de GAME OVER
                        const Text(
                          "GAME OVER",
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),

                        ///textos de puntos y mejor puntuación
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text("Points: $puntos"),
                            Text("Best: $mejorPuntuacion")
                          ],
                        )
                      ],
                    ),
                  ),
                  actions: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ///Botón para reintentar el juego
                        Boton(
                          icon: Icons.rotate_left,
                          function: () {
                            bolaVelocidadX =
                                Random.secure().nextDouble() * (0.02 - 0.003) +
                                    0.02;
                            jugar();
                            Navigator.pop(context);
                          },
                          height: 60,
                          width: 60,
                          color: Colors.white,
                        ),

                        ///Botón para volver al menú
                        Boton(
                          icon: Icons.menu,
                          function: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          height: 60,
                          width: 60,
                          color: Colors.white,
                        )
                      ],
                    )
                  ],
                ),
            barrierDismissible: false);
      }
    });
  }

  double alturaAPosicion(double altura) {
    double alturaTotal = MediaQuery.of(context).size.height * 3 / 4;
    double posicion = 1 - 2 * altura / alturaTotal;
    return posicion;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Espacio de botones y movimiento de la canasta y la bola
        Expanded(
            flex: 5,
            child: Container(
              color: Colors.lightBlue,
              child: Center(
                child: Stack(
                  children: [
                    Plataforma(
                      posicionX: plataformaPosX,
                    ),
                    Container(
                      alignment: const Alignment(0, -0.9),
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 100,
                          color: Colors.red,
                        ),
                        child: Text("$segundos"),
                      ),
                    ),
                    Container(
                      alignment: const Alignment(0, -0.1),
                      child: DefaultTextStyle(
                        style: const TextStyle(fontSize: 40),
                        child: Text("$puntos"),
                      ),
                    ),
                    Bola(
                      posicionX: bolaPosX,
                      posicionY: bolaPosY,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Boton(
                            function: moverPlataforma1,
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Boton(
                            function: moverPlataforma2,
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Boton(
                            function: moverPlataforma3,
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Boton(
                            function: moverPlataforma4,
                            color: Colors.transparent,
                          ),
                        ),
                        Expanded(
                          child: Boton(
                            function: moverPlataforma5,
                            color: Colors.transparent,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      alignment: const Alignment(-0.95, -0.95),
                      child: Boton(
                        function: () {
                          segundos = 0;
                          Navigator.pop(context);
                        },
                        icon: Icons.menu,
                        color: Colors.white,
                        width: 75,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ),
            )),
        //Suelo
        Expanded(
            child: Container(
          color: Colors.lightGreen,
          child: Row(
            children: [
              Expanded(
                child: Boton(
                  function: moverPlataforma1,
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Boton(
                  function: moverPlataforma2,
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Boton(
                  function: moverPlataforma3,
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Boton(
                  function: moverPlataforma4,
                  color: Colors.transparent,
                ),
              ),
              Expanded(
                child: Boton(
                  function: moverPlataforma5,
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ))
      ],
    );
  }
}
