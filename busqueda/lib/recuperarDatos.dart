import 'package:busqueda/traerDatos.dart';
import 'package:flutter/material.dart';

import 'operaciones.dart';

class RecuperarDatos extends StatelessWidget{
    @override
  Widget build(BuildContext context) {
      return WillPopScope( //Para controlar el boton de retroceso
        onWillPop: () async { //Con esto se puede controlar el boton de retroceso pero hay un parpadeo cuando se retrocede
          await Navigator.of(context).pushNamedAndRemoveUntil('/', (Route <dynamic> route) => false);
          //Navigator.popAndPushNamed(context, "/");
          return true;
          },
        child: Scaffold(
          body: RecuperarDatosF()
        )
      );
  }
}

class RecuperarDatosF extends StatefulWidget{
  
  RecuperarDatosState createState() => RecuperarDatosState();
}

class RecuperarDatosState extends State<RecuperarDatosF> {

  List calificacion = ["1","2","3","4","5"];
  String selectCalif = "1";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              delegate: MisDatos(expandedHeight: 200),
              pinned: true,
            ),
            SliverList(

              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) => _misDatos(context),
                childCount: 1 
              ),
            )
          ],
        ),
      ),
    );
  }

  _misDatos(BuildContext context){
    MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        
            
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children :[
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 100),
                  child: Row(children: [
                    Text("Calificación: " + arguments.calif),
                    Operacion.nivelCalificacion(int.parse(arguments.calif))
                  ],)
                ),
                Text(arguments.nombreApellido, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text("Calificar:"),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child:_selectComboBoxCalificar(),
                    ),
                    
                    IconButton(
                      icon: Icon(Icons.check),
                      iconSize: 30,
                      color: Colors.green,
                      splashColor: Color(0XFF2E5596),
                      onPressed: () {
                        refrescar();
                      }
                    )
                    
                  ],
                ),
              ]
            )
          ]
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          child: Operacion.getIconDatos(Icon(Icons.assignment_ind), "CI: " + arguments.ci),
        ),
        Operacion.getIconDatos(Icon(Icons.location_on), "Dirección: " + arguments.direccion),
        Operacion.getIconDatos(Icon(Icons.work), "Profesión: " + arguments.profesion),
        Operacion.getIconDatos(Icon(Icons.timer), "Turno: " + arguments.turno),
        Operacion.getIconDatos(Icon(Icons.note), "Descripción: " + arguments.descrip),
      ],
    );
  }

  _selectComboBoxCalificar(){
     return new DropdownButton(
                value: selectCalif,
                items: calificacion.map((item){
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item 
                      );
                  }).toList(),
                onChanged: (value){
                  setState(() {
                    selectCalif = value;
                  });
                }
              );
    
  }

  Future<Null> refrescar() async {
    MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
    String cal = await TraerDatos.calificar(selectCalif, arguments.ci, arguments.idServi);
    await new Future.delayed(new Duration(milliseconds: 1));
    setState((){
      arguments.calif = cal;
    });
    return null;
  }

}

class MisDatos extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MisDatos({@required this.expandedHeight});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    MisDatosParam arguments = ModalRoute.of(context).settings.arguments;
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0XFF2E5596),
                Color(0XFF16304E),
              ],
            ),
          ),
        ),
        Center(
          child: AppBar(title: Text(arguments.nombreApellido), backgroundColor: Colors.black12,)
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 3.5,
          child: Opacity(
            opacity: (1 - shrinkOffset / expandedHeight),
            child: Container(
              
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.green, width: 3),
                
                image: DecorationImage(
                  image: AssetImage("assets/icono4.png"),
                  fit: BoxFit.contain
                ),
              ),

              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2.5,
                
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}


class MisDatosParam{
  String ci;
  String nombreApellido;
  String direccion;
  String profesion;
  String turno;
  String descrip;
  String calif;
  String idServi;

  MisDatosParam({this.ci, this.nombreApellido, this.direccion, this.profesion, this.turno, this.descrip, this.calif, this.idServi});
}