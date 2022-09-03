import 'package:flutter/material.dart';
import 'package:rest_dragon_ball/clases/personajeDragonBall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'dart:developer';

//Pagina Personajes
class PaginaPersonajesDB extends StatelessWidget {
  //Recibo por parametro mi array con los resultados del response
  PaginaPersonajesDB({this.arrayPersonajes});

  //Declaro el array recibido por parametro
  final arrayPersonajes;

  //Widget constructor de la pantalla
  @override
  Widget build(BuildContext context) {
    return arrayPersonajes.isEmpty
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : renderizarPersonajesObtenidos(arrayPersonajes);
  }
}

//Definimos el Widget para renderizar los personajes
Widget renderizarPersonajesObtenidos(arrayPersonajes) {
  //inspect(arrayPersonajes);

  //Creo una lista de vistas
  return ListView.builder(
      //El limite estara dado por el tam maximo del response de personajes
      itemCount: arrayPersonajes.length,
      itemBuilder: (_, index) {
        //Retorno un Container principal
        return Container(
          //Le doy margenes a los contenedores..
          margin: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          //Cada personaje sera una Card..
          child: Card(
            elevation: 5.0,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Container(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                //En los elementos hijos diseño la estructura
                children: <Widget>[
                  //Nombre del Personaje
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      arrayPersonajes[index].name,
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    )),
                  ),
                  //Imagen del Personaje
                  Container(
                    padding: const EdgeInsets.all(30.0),
                    child: Center(
                        child: Image.network(arrayPersonajes[index].imageUrl)),
                  ),
                  //Especie del personaje
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      arrayPersonajes[index].specie,
                      style: const TextStyle(fontSize: 16),
                    )),
                  ),
                  //Universo del Personaje
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      arrayPersonajes[index].universe,
                      style: const TextStyle(fontSize: 16),
                    )),
                  ),
                  //Planeta de Origen
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                        child: Text(
                      arrayPersonajes[index].originplanet,
                      style: const TextStyle(fontSize: 16),
                    )),
                  ),
                ],
              ),
            ),
          ),
        );
      });
}
