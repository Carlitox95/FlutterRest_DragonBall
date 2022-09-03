// ignore_for_file: prefer_const_constructors, unnecessary_new, must_be_immutable

import 'package:flutter/material.dart';
import 'package:rest_dragon_ball/clases/personajeDragonBall.dart';
import 'package:rest_dragon_ball/paginas/paginaHome.dart';
import 'package:rest_dragon_ball/paginas/paginaPersonajes.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import 'main.dart';

//Aplicacion para iniciar la App
void main() => runApp(new MyApp());

//La aplicacion admite estados por eso es "StatefullWidget"
class MyApp extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

//Clase de estado principal
class _MyAppState extends State<MyApp> {
  //Defino una lista para los datos que recolecto de la Api
  List<personajeDragonBall> arrayPersonajes = [];
  //Defino una variable para almacenar la pagina activa
  int _paginaActual = 0;

  //De forma inicial vamos a ejecutar la funcion..
  void initState() {
    getApiPersonajes();
  }

  //Lista de Widgets para las paginas que tengo
  late final List<Widget> _paginas = [
    PaginaHome(),
    PaginaPersonajesDB(
      arrayPersonajes: arrayPersonajes,
    )
  ];

  //Funcion para cargar los datos de la Api
  getApiPersonajes() async {
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
      //inspect(json.decode(responeBody));
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
    } else {
      print('Error en el Response');
    }
  }

  //Defino el Widget Constructor principal
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Flutter API Response - Carlitox'),
          ),
          //Le paso al array de paginas el nro de pagina actual a renderizar..
          body: _paginas[_paginaActual],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _paginaActual = index;
              });
            },
            currentIndex: _paginaActual,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.image_search_rounded),
                  label: "Personajes Api")
            ],
          ),
        ));
  }
}
