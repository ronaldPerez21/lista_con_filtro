import 'package:flutter/material.dart';

class Operacion{

  static textosEstilosDif(String valor, {TextStyle estilo}){
    return Text.rich(
      TextSpan(
        children: <TextSpan>[
          TextSpan(
              text: valor,
              style: estilo
          )
        ],
      ),
    );
  }

  
  static nivelCalificacion(int n){
    List<Icon> estrellas = new List();
    for(int i = 1; i<=5; i++){
      if(i<=n)
        estrellas.add(Icon(Icons.star, color: Colors.green[500]));
      else
        estrellas.add(Icon(Icons.star, color: Colors.black));
    }
    return Row(
      children: [
        estrellas[0],
        estrellas[1],
        estrellas[2],
        estrellas[3],
        estrellas[4],
      ],
    );
  }


  static getIconDatos(Icon icono, String descri){
    return  Card(
      child: Row(
          children: [
            icono,
            Text("  "),
            Text(descri),
          ],
          
      )
    );
  }
}