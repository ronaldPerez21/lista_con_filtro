import 'package:busqueda/recuperarDatos.dart';
import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';

import 'operaciones.dart';


class DatosBusqueda extends StatefulWidget {
  DatosBusqueda({Key key}) : super(key: key);

  @override
  _DatosBusquedaState createState() => _DatosBusquedaState();
}

class _DatosBusquedaState extends State<DatosBusqueda>{
  
  
  
  @override
  Widget build(BuildContext context) {
    ParametroBusqueda arguments = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(title: Text("Lista de Trabajos"), backgroundColor: Colors.black45),
      body: FutureBuilder<List> ( 
        future: TraerDatos.buscarUsuario(arguments.servicio, arguments.ubicacion, arguments.turno),
        builder: (context, snapshot) {
            if(snapshot.hasError) print(snapshot.error);
            return snapshot.hasData
                ? _createItem(
              lista: snapshot.data,
            )
                : new Center(
              child: new CircularProgressIndicator(),
            );
          },
      ),
    );
  }


  Widget _createItem({List lista}) {

      return ListView.builder(
        itemCount: lista == null ? 0: lista.length,
        itemBuilder: (context, index) {
      return GestureDetector( 
        onTap: (){
          Navigator.of(context).pushNamed("/recuperarDatos", arguments: MisDatosParam(ci: lista[index]['ci'],
                                                                                      nombreApellido: lista[index]['nombreYApellido'],
                                                                                      direccion: lista[index]['nombreUbicacion'],
                                                                                      profesion: lista[index]['nombre'],
                                                                                      turno: lista[index]['turno'],
                                                                                      descrip: lista[index]['descripcion'],
                                                                                      calif: lista[index]['calificacion'],
                                                                                      idServi: lista[index]['id']
                                                                                      ));

        },
        child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:20, top: 20),
            child: Container(
              width: 320,
              height: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [

                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Icon(Icons.face, size: 100,)
                        ),

                        Positioned(
                          left: 110,
                          bottom: 92, 
                          child: Operacion.textosEstilosDif("Nombre: " + lista[index]['nombreYApellido'],
                          estilo: TextStyle(fontSize: 14, fontWeight: FontWeight.bold )),
                        ),

                        Positioned(
                          left: 120,
                          top: 30,
                          child: Operacion.textosEstilosDif("Dirección: " + lista[index]['nombreUbicacion']),
                        ),

                        Positioned(
                          left: 120,
                          top: 45,
                          child: Operacion.textosEstilosDif("Profesión: " + lista[index]['nombre']),
                        ),

                        Positioned(
                          left: 120,
                          top: 60,
                          child: Operacion.textosEstilosDif("Turno: " + lista[index]['turno']),
                        ),

                        Positioned(
                          left: 120,
                          top: 75,
                          child: Operacion.textosEstilosDif("Calificación: " + lista[index]['calificacion']),
                        ),
                        
                      Padding(
                        padding: EdgeInsets.only(top: 100), 
                        child: Operacion.nivelCalificacion(int.parse(lista[index]['calificacion']))
                      )
                    ]
                  )
                ],
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.black),
                borderRadius: const BorderRadius.all(const Radius.circular(20)),
                color: Colors.grey[300],
              ),
            ),
          ),
        ],
      ),
     );
    }
    );
  }


}

class ParametroBusqueda{
  String servicio;
  String ubicacion;
  String turno;

  ParametroBusqueda({this.servicio, this.ubicacion, this.turno});
}