// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:rest_dragonball/personajeDragonBall.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

//Aplicacion para iniciar la App
void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

//Clase Principal
class _MyAppState extends State<MyApp> {
  //Defino una lista para los datos que recolecto de la Api
  List<personajeDragonBall> arrayPersonajes = [];

  //Al iniciar la App indico que dispare la funcion para la api
  @override
  void initState() {
    loadApiRest();
  }

  //Funcion para cargar los datos de la Api
  loadApiRest() async {
    //Defino el response
    var response = await http.get(
        Uri.parse('https://dragon-ball-super-api.herokuapp.com/api/characters'),
        headers: {"Aceept": "application/json"});

    //Si obtengo una respuesta exitosa
    if (response.statusCode == 200) {
      String responeBody = response.body;
      //Me guardo el Json response
      var jsonBody = json.decode(responeBody);
      //Itero sobre cada dato obtenido de mi response
      for (var data in jsonBody) {
        //Por cada dato obtenido agrego un modelo mas a la lista de modelos
        arrayPersonajes.add(
            //Defino cada modelo de cada personaje
            personajeDragonBall(
                data['id'],
                data['name'],
                data['specie'],
                data['imageUrl'],
                data['universe'],
                data['status'],
                data['originplanet']));
      }
      setState(() {});
      arrayPersonajes.forEach((someData) => print("Name : ${someData.name}"));
    } else {
      print('Algo salio mal che');
    }
  }

  //Defino el Widget Constructor
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        home: new Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter API Response - Carlitox'),
      ),
      //Si el array esta vacio, muestro la pantalla de carga..
      body: arrayPersonajes.isEmpty
          ? new Center(
              child: new CircularProgressIndicator(),
            )
          : renderizarPersonajesObtenidos(),
    ));
  }

  //Definimos el Widget para mostrar los personajes
  Widget renderizarPersonajesObtenidos() {
    //Creo una lista de vistas
    return new ListView.builder(
        //El limite estara dado por el tam maximo del response de personajes
        itemCount: arrayPersonajes.length,
        itemBuilder: (_, index) {
          //Retorno un Container principal
          return new Container(
            //Le doy margenes a los contenedores..
            margin: new EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
            //Cada personaje sera una Card..
            child: new Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      topRight: Radius.circular(30))),
              child: new Container(
                padding: new EdgeInsets.all(50.0),
                child: new Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  //En los elementos hijos diseño la estructura
                  children: <Widget>[
                    //Nombre del Personaje
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        arrayPersonajes[index].name,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                    ),
                    //Imagen del Personaje
                    Container(
                      padding: EdgeInsets.all(30.0),
                      child: Image.network(arrayPersonajes[index].imageUrl),
                    ),
                    //Especie del personaje
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        arrayPersonajes[index].specie,
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                    //Universo del Personaje
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        arrayPersonajes[index].universe,
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                    //Planeta de Origen
                    Container(
                      padding: EdgeInsets.all(20.0),
                      child: Center(
                          child: Text(
                        arrayPersonajes[index].originplanet,
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
