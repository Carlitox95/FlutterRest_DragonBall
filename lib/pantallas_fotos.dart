import 'package:flutter/material.dart';

void main() => runApp(MiApp());

class MiApp extends StatelessWidget {
  const MiApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mi App",
      home: Inicio(),
    );
  }
}

class Inicio extends StatefulWidget {
  Inicio({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Mi App"),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                  "https://alfabetajuega.com/hero/2020/09/Goku-Ultra-Instinto.jpg?width=1200&aspect_ratio=16:9"),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                  "https://static.wikia.nocookie.net/dragonball/images/d/d9/FinalBeastGohan.jpg/revision/latest/scale-to-width-down/350?cb=20220628225714"),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                  "https://alfabetajuega.com/hero/2020/09/Goku-Ultra-Instinto.jpg?width=1200&aspect_ratio=16:9"),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: Image.network(
                  "https://alfabetajuega.com/hero/2020/09/Goku-Ultra-Instinto.jpg?width=1200&aspect_ratio=16:9"),
            ),
          ],
        ));
  }
}
