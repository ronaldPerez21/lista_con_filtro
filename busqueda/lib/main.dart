import 'package:busqueda/busqueda.dart';
import 'package:busqueda/datosBusqueda.dart';
import 'package:busqueda/recuperarDatos.dart';
import 'package:flutter/material.dart';

import 'listaTrabajos.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => ListaTrabajos(),
        "/busqueda": (BuildContext context) => MyAppR(),
        "/busquedaDatos": (BuildContext context) => DatosBusqueda(),
        "/recuperarDatos": (BuildContext context) => RecuperarDatos()
      }
    );
  }
}

