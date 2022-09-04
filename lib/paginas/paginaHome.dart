import 'package:flutter/material.dart';
import 'package:rest_dragon_ball/clases/articuloNoticia.dart';
import 'dart:developer';

//Pagina Home
class PaginaHome extends StatelessWidget {
  const PaginaHome({Key? key, this.arrayNoticias}) : super(key: key);
  //Declaro el array recibido por parametro
  final arrayNoticias;

  @override
  Widget build(BuildContext context) {
    return Center(child: renderizarNoticiasObtenidas(arrayNoticias));
  }
}

//Widget que retorna noticias
Widget renderizarNoticiasObtenidas(arrayNoticias) {
  //Creo una lista de vistas
  return ListView.builder(
      //El limite estara dado por el tam maximo
      itemCount: arrayNoticias.length,
      itemBuilder: (_, index) {
        return Card(
          clipBehavior: Clip.antiAlias,
          color: Color.fromARGB(255, 243, 239, 239),
          margin: (const EdgeInsets.symmetric(horizontal: 20.20, vertical: 20)),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.arrow_drop_down_circle),
                title: Text(arrayNoticias[index].title),
                subtitle: Text(
                  arrayNoticias[index].author,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  arrayNoticias[index].description,
                  style: TextStyle(color: Colors.black.withOpacity(0.6)),
                ),
              ),
              Image.network(arrayNoticias[index].urlToImage),
              ButtonBar(
                alignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      overlayColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.hovered)) {
                            return Colors.blue.withOpacity(0.04);
                          }
                          if (states.contains(MaterialState.focused) ||
                              states.contains(MaterialState.pressed)) {
                            return Colors.blue.withOpacity(0.12);
                          }
                          return null; // Defer to the widget's default.
                        },
                      ),
                    ),
                    onPressed: () {
                      // Perform some action
                    },
                    child: const Text('Ver Noticia'),
                  ),
                ],
              ),
            ],
          ),
        );
      });
}
