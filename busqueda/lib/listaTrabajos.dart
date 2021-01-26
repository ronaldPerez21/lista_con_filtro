import 'package:busqueda/recuperarDatos.dart';
import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';
import 'operaciones.dart';

class ListaTrabajos extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista de Trabajos"), backgroundColor: Colors.black45),
      body: ListaTrabajosF(),
      drawer: _getDrawer(context),
    );
  }

  Widget _getDrawer(BuildContext context){
    return Container(
      width: 200,
      child: Drawer(
      child: ListView(
        children: <Widget>[
          //Esto es una forma, pero tambien podemos hacerlo con el UserAccountsDrawerHeader, ej:
            DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple
              ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Icon(
                  Icons.account_box,
                  size: 40,
                  ),
                
                  Padding(
                    padding: const EdgeInsets.only(top: 100, right: 30),
                    child: Text("Mis datos",
                    style: TextStyle(color: Colors.black, fontSize: 20)
                    ),
                  ) 
                      
             ],
           )
          ),

          Card(
            color: Colors.black45,
            child: ListTile(
            title: Text("Buscar"),
            leading: Icon(Icons.search),
            onTap: ()=>Navigator.of(context).pushNamed("/busqueda")
            )
          )
        ],
        ),
      )
    );
  }

}

class ListaTrabajosF extends StatefulWidget{

  ListaTrabajosState createState() => ListaTrabajosState();
}

class ListaTrabajosState extends State<ListaTrabajosF>{

  var lista;

  Widget build(BuildContext context) {
    
    return Scaffold(
      body: createItem() //Reemplaza al de abajo
      // FutureBuilder<List> ( 
      //   future: TraerDatos.getTodosServicios(),
      //   builder: (context, snapshot) {
      //       if(snapshot.hasError) print(snapshot.error);
      //       return snapshot.hasData
      //           ? _createItem(
      //         lista: snapshot.data,
      //       )
      //           : new Center(
      //         child: new CircularProgressIndicator(),
      //       );
      //     },
      // ),
    );
  }

  void initState(){
    super.initState();
    refrescar();

  }

  Future<Null> refrescar() async {
    await new Future.delayed(new Duration(milliseconds: 1));
    var auxLista = await TraerDatos.getTodosServicios();
    setState((){
      lista = auxLista;
    });
    return null;
  }

  Widget createItem() {

      return RefreshIndicator( 
      child: ListView.builder(
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
                          padding: const EdgeInsets.only(left: 10, top: 18),
                          child: Image.asset("assets/icono4.png", width: 100, height: 80)
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(left: 10),
                        // child: Image.network(
                        //   "https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_man_people_person_profile_user_icon_123385.png",
                        //   height: 100, width: 100),
                        // ),

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
    ),
    onRefresh: refrescar,
    );
  }
  

}





// class ListaTrabajosFul extends StatefulWidget{

// ListaTrabajosState createState() => ListaTrabajosState();

// }

// class ListaTrabajosState extends State<ListaTrabajosFul>{

//   Future<List> getTodosServicios() async {  
//     http.Response response = await http.get('http://localhost/busqueda_empleos/datos/todosServicios.php');

//       return json.decode(response.body);
//   }

//   @override
//   Widget build(BuildContext context) {
    
//     return Scaffold(
//       appBar: AppBar(title: Text("Lista de Trabajos"), backgroundColor: Colors.black45),
//       body: FutureBuilder<List> ( 
//         future: getTodosServicios(),
//         builder: (context, snapshot) {
//             if(snapshot.hasError) print(snapshot.error);
//             return snapshot.hasData
//                 ? _createItem(
//               lista: snapshot.data,
//             )
//                 : new Center(
//               child: new CircularProgressIndicator(),
//             );
//           },
//       ),
//       drawer: _getDrawer(context),
//     );
//   }

//   Widget _getDrawer(BuildContext context){
//     return Container(
//       width: 200,
//       child: Drawer(
//       child: ListView(
//         children: <Widget>[
//           //Esto es una forma, pero tambien podemos hacerlo con el UserAccountsDrawerHeader, ej:
//             DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.purple
//               ),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Icon(
//                   Icons.account_box,
//                   size: 40,
//                   ),
                
//                   Padding(
//                     padding: const EdgeInsets.only(top: 100, right: 30),
//                     child: Text("Mis datos",
//                     style: TextStyle(color: Colors.black, fontSize: 20)
//                     ),
//                   ) 
                      
//              ],
//            )
//           ),

//           Card(
//             color: Colors.black45,
//             child: ListTile(
//             title: Text("Buscar"),
//             leading: Icon(Icons.search),
//             onTap: ()=>pasarBusqueda(context)
//             )
//           )
//         ],
//         ),
//       )
//     );
//   }

//   // _mostrarItem(){
//   //   return ListView.builder(
//   //           itemCount: 13,  
//   //           //itemBuilder: (context, index) => _createItem(context, index)
          
//   //       );
//   // }

//     Widget _createItem({List lista}) {

//       return ListView.builder(
//         itemCount: lista == null ? 0: lista.length,
//         itemBuilder: (context, index) {
//       return GestureDetector( 
//         onTap: (){
//           Navigator.of(context).pushNamed("/recuperarDatos");

//         },
//         child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left:20, top: 20),
//             child: Container(
//               width: 320,
//               height: 130,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [

//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Image.network(
//                           "https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_man_people_person_profile_user_icon_123385.png",
//                           height: 100, width: 100),
//                         ),

//                         Positioned(
//                           left: 110,
//                           bottom: 92, 
//                           child: Operacion.textosEstilosDif("Nombre: " + lista[index]['nombreYApellido'],
//                           estilo: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 30,
//                           child: Operacion.textosEstilosDif("Dirección: " + lista[index]['nombreUbicacion']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 45,
//                           child: Operacion.textosEstilosDif("Profesión: " + lista[index]['nombre']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 60,
//                           child: Operacion.textosEstilosDif("Turno: " + lista[index]['turno']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 75,
//                           child: Operacion.textosEstilosDif("Calificación: " + lista[index]['calificacion']),
//                         ),
                        
//                       Padding(
//                         padding: EdgeInsets.only(top: 100), 
//                         child: Operacion.nivelCalificacion(int.parse(lista[index]['calificacion']))
//                       )
//                     ]
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1, color: Colors.black),
//                 borderRadius: const BorderRadius.all(const Radius.circular(20)),
//                 color: Colors.grey[300],
//               ),
//             ),
//           ),
//         ],
//       ),
//      );
//     }
//     );
//   }


//   void pasarBusqueda(BuildContext context){
//     Navigator.of(context).pushNamed("/busqueda");
//   }

// }


// class ElementosLista extends StatelessWidget{
//   final List lista;
//   ElementosLista({this.lista});

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//         itemCount: lista == null ? 0: lista.length,
//         itemBuilder: (context, index) {
//       return GestureDetector( 
//         onTap: (){
//           Navigator.of(context).pushNamed("/recuperarDatos");

//         },
//         child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left:20, top: 20),
//             child: Container(
//               width: 320,
//               height: 130,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Stack(
//                     children: [

//                         Padding(
//                           padding: const EdgeInsets.only(left: 10),
//                           child: Image.network(
//                           "https://cdn.icon-icons.com/icons2/1999/PNG/512/avatar_man_people_person_profile_user_icon_123385.png",
//                           height: 100, width: 100),
//                         ),

//                         Positioned(
//                           left: 110,
//                           bottom: 92, 
//                           child: Operacion.textosEstilosDif("Nombre: " + lista[index]['nombreYApellido'],
//                           estilo: TextStyle(fontSize: 20, fontWeight: FontWeight.bold )),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 30,
//                           child: Operacion.textosEstilosDif("Dirección: " + lista[index]['nombreUbicacion']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 45,
//                           child: Operacion.textosEstilosDif("Profesión: " + lista[index]['nombre']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 60,
//                           child: Operacion.textosEstilosDif("Turno: " + lista[index]['turno']),
//                         ),

//                         Positioned(
//                           left: 120,
//                           top: 75,
//                           child: Operacion.textosEstilosDif("Calificación: " + lista[index]['calificacion']),
//                         ),
                        
//                       Padding(
//                         padding: EdgeInsets.only(top: 100), 
//                         child: Operacion.nivelCalificacion(int.parse(lista[index]['calificacion']))
//                       )
//                     ]
//                   )
//                 ],
//               ),
//               decoration: BoxDecoration(
//                 border: Border.all(width: 1, color: Colors.black),
//                 borderRadius: const BorderRadius.all(const Radius.circular(20)),
//                 color: Colors.grey[300],
//               ),
//             ),
//           ),
//         ],
//       ),
//      );
//     }
//     );
//   }

  
// }