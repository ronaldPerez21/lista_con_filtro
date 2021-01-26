import 'package:busqueda/traerDatos.dart';
import "package:flutter/material.dart";
import 'dart:async';

import 'datosBusqueda.dart';

class MyAppR extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: Text("Mi busqueda"), backgroundColor: Colors.black45,),
      body: MyApp()
      );
  }

  
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List listaServices = List(); //edited line
  List listaLocation = List();
  List listaHorario = ["Mañana", "Tarde", "Noche"];
  String _selectService;
  String _selectLocation;
  String _selectHorario;

  // Future<String> getSWData() async {
  //   var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
  //   var resBody = json.decode(res.body);
  //   setState(() {
  //     data = resBody;
  //     _mySelection = data[0]['nombre'];
  //   });

  //   print(resBody);

  //   return "Sucess";
  // }

  Future<void> getDatos() async {
    List auxServicio = await TraerDatos.getServicios();
    List auxLocation = await TraerDatos.getUbicacion();
    setState(() {
      listaServices = auxServicio;
      listaLocation = auxLocation;
      _selectService = listaServices[0]['nombre'];
      _selectLocation = listaLocation[0]['nombre'];
      _selectHorario = listaHorario[0];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getDatos();
    //print("valores: $this.data");
  }

  @override
  Widget build(BuildContext context) {
    return Row(
            //crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            Column(
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text("Seleccione el servicio"),
                ),
                _selectComboBoxServicio(),

                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text("Seleccione el Lugar"),
                ),
                _selectComboBoxLocation(),


                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text("Seleccione el turno"),
                ),
                _selectComboBoxHorario(),
                
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: RaisedButton(
                    color: Colors.black45,
                    textColor: Colors.black,
                    child: Text("Buscar"),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onPressed: () => Navigator.of(context).pushNamed("/busquedaDatos",
                                                                       arguments: ParametroBusqueda(servicio: _selectService,
                                                                                                    ubicacion: _selectLocation,
                                                                                                    turno: turnoInt(_selectHorario).toString()))
                  ),
                )

              ]
            )
            ],
          );
  }

  List<DropdownMenuItem<dynamic>> _listaComboBox(List categoria, String valor){
    return categoria.map((item){
      return DropdownMenuItem(
        child: Text(item[valor]),
        value: item[valor] 
        );
    }).toList();
  }

  _selectComboBoxServicio(){
     return new Container(
              child: new DropdownButton(
                value: _selectService,
                items: _listaComboBox(listaServices, 'nombre'),
                onChanged: (value){
                  setState(() {
                    _selectService = value;
                  });
                }
              )
    );
  }

  _selectComboBoxLocation(){
     return new Container(
              child: new DropdownButton(
                value: _selectLocation,
                items: _listaComboBox(listaLocation, 'nombre'),
                onChanged: (value){
                  setState(() {
                    _selectLocation = value;
                  });
                }
              )
    );
  }

  _selectComboBoxHorario(){
     return new Container(
              child: new DropdownButton(
                value: _selectHorario,
                items: listaHorario.map((item){
                    return DropdownMenuItem(
                      child: Text(item),
                      value: item 
                      );
                  }).toList(),
                onChanged: (value){
                  setState(() {
                    _selectHorario = value;
                  });
                }
              )
    );
  }

  int turnoInt(String s){
   
   switch(s){
     case 'Mañana': return 1;
     break;
     case 'Tarde': return 2;
     break;
     case 'Noche': return 3;
     break;
     default: return -1;
   }
 }


}